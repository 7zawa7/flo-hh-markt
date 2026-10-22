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

Die Anmeldung „Ich bin dabei“ läuft über Supabase. Die Zugangsdaten stehen in `SUPA` in `index.html`. Solange sie leer sind, zeigt die Seite „Anmeldung startet bald“.
