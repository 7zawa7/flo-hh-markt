# flo.hh.markt

Jeder Flohmarkt in Hamburg, mit Weckzeit und Route. Die Seite zeigt immer den nächsten Flohmarkt und plant bei mehreren Märkten an einem Tag die beste Reihenfolge, die Fahrzeiten und wann du aufstehen musst.

## Lokal starten

Du brauchst nur einen kleinen Webserver. Eine der beiden Varianten reicht:

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
