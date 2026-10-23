# flo.hh.markt

Alle Hamburger Flohmärkte. Und wann du am besten wohin fährst. Die Seite zeigt immer den nächsten Flohmarkt und plant bei mehreren Märkten an einem Tag die beste Reihenfolge, die Fahrzeiten und wann du aufstehen musst.

## Lokal starten

**Am Mac am einfachsten:** Doppelklick auf `start.command`. Die Seite öffnet sich dann unter <http://localhost:8080>. Beim ersten Mal fragt macOS eventuell nach: dann Rechtsklick auf die Datei → Öffnen.

Alternativ brauchst nur einen kleinen Webserver. Eine der beiden Varianten reicht:

**Mit Node.js**

```bash
npm start
```

**Mit Python**

```bash
python3 -m http.server 8080
```

Dann im Browser öffnen: <http://localhost:8080>

Du kannst `index.html` auch einfach per Doppelklick öffnen, das funktioniert ebenfalls.

## Termine aktualisieren

Alle Termine stehen in `index.html` in der Liste `RAW`. Jede Zeile hat das Format:

```js
["2026-11-07", "schanze", "08:00", "16:00"]
```

Die Orte (Name, Stadtteil, Koordinaten, Stöberzeit) stehen darüber im Objekt `P`. Neue Termine gibt es im [Flohmarktkalender von hamburg.de](https://www.hamburg.de/freizeit/maerkte-und-messen/flohmaerkte).

## Dateien

- `index.html`: die komplette Seite
- `assets/logo.svg`: Wortmarke
- `assets/icon.svg`: Icon, auch als Favicon genutzt

## Bewertungen, Andrang und Wetter

- `MI` in `index.html` enthält pro Markt Fundchancen (0–10), typischen Andrang (0–10), Überdachung, Stichworte, eine kurze Einschätzung und Quellen. Stand: 23.10.2026, recherchiert aus öffentlichen Berichten und Bewertungen.
- Der erwartete Andrang (`crowdAt`) ergibt sich aus diesem Grundwert, Wochentag, Uhrzeit, Wetter (Open-Meteo, ohne Schlüssel) und der Zahl der Anmeldungen.
- Die Routenplanung bevorzugt Märkte mit guten Fundchancen, möglichst früh nach Öffnung und bei wenig Andrang. Zu jeder Station steht eine kurze Begründung.

## Anmeldung (Supabase)

Die Anmeldung „Ich bin dabei“ läuft über Supabase. Die Zugangsdaten stehen in `SUPA` in `index.html`. Projekt: `flo-hh-markt` in der Supabase-Organisation enzolutions. Die Tabelle `signups` ist nur über die Funktionen `flohm_toggle` und `flohm_counts` erreichbar.

Dazu kommt „Wie voll war's?“: Am Markttag können Besucher:innen angeben, wie voll es war. Das landet in `flohm_reports` (nur über `flohm_report` und `flohm_crowd` erreichbar, SQL in `supabase/reports.sql`). Sobald Rückmeldungen da sind, fließen sie in `crowdAt` ein und ersetzen nach und nach die Schätzung. Neue Märkte müssen in `flohm_report` in die Liste der erlaubten IDs.

## Rechtliches und Datenschutz

- `impressum.html`: Impressum (enzolutions · Enzo Zawarty) mit Hinweis zum KI-Einsatz (Art. 50 KI-VO)
- `datenschutz.html`: Datenschutzerklärung (GitHub Pages, Local Storage, Supabase, Open-Meteo, cdnjs für den PDF-Export)
- `404.html`, `robots.txt`, `sitemap.xml`, `assets/og.png` (Vorschaubild beim Teilen), `assets/apple-touch-icon.png`
- Die Überschriften-Schrift liegt unter `assets/fonts/`, es wird nichts von Google Fonts geladen.
- Die Geräte-Kennung für „Ich bin dabei“ entsteht erst beim ersten Antippen. Anmeldungen für vergangene Tage löscht die Datenbank automatisch.
