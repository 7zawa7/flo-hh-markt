-- flo.hh.markt: Rückmeldungen „Wie voll war's?“
-- Im Supabase SQL-Editor ausgeführt am 23.10.2026.
create table if not exists public.flohm_reports(
  market text not null,
  day date not null,
  hour smallint not null check (hour between 5 and 23),
  level smallint not null check (level between 1 and 4),
  device text,
  created_at timestamptz not null default now()
);
create unique index if not exists flohm_reports_once on public.flohm_reports(market, day, device);
create index if not exists flohm_reports_mh on public.flohm_reports(market, hour);
alter table public.flohm_reports enable row level security;
revoke all on public.flohm_reports from anon, authenticated;

create or replace function public.flohm_report(p_market text, p_day date, p_hour int, p_level int, p_device text)
returns boolean language plpgsql security definer set search_path = public as $$
declare today date := (now() at time zone 'Europe/Berlin')::date;
begin
  if p_market not in ('bahrenfeld','horn','schanze','langereihe','elserauch','nachtrmh','rmh','basch','spielzeug','gleishalle','kreativ73')
     or p_level not between 1 and 4 or p_hour not between 5 and 23
     or p_day not between today - 1 and today
     or length(coalesce(p_device,'')) not between 8 and 64 then
    raise exception 'invalid';
  end if;
  -- Geräte-Kennung wird nach zwei Tagen entfernt
  update flohm_reports set device = null where device is not null and day < today - 1;
  if (select count(*) from flohm_reports where market = p_market and day = p_day) >= 500 then return false; end if;
  insert into flohm_reports(market, day, hour, level, device) values (p_market, p_day, p_hour, p_level, p_device)
  on conflict (market, day, device) do update set level = excluded.level, hour = excluded.hour, created_at = now();
  return true;
end $$;

create or replace function public.flohm_crowd()
returns table(market text, hour smallint, avg_level numeric, n bigint)
language sql stable security definer set search_path = public as $$
  select r.market, r.hour, round(avg(r.level)::numeric, 2), count(*)
  from flohm_reports r
  where r.day > (now() at time zone 'Europe/Berlin')::date - 365
  group by r.market, r.hour
$$;

revoke execute on function public.flohm_report(text, date, int, int, text) from public;
revoke execute on function public.flohm_crowd() from public;
grant execute on function public.flohm_report(text, date, int, int, text) to anon, authenticated;
grant execute on function public.flohm_crowd() to anon, authenticated;
