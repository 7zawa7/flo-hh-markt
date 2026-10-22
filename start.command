#!/bin/bash
# flo.hh.markt lokal starten: Doppelklick auf diese Datei
cd "$(dirname "$0")"
PORT=8080
echo "flo.hh.markt läuft auf http://localhost:$PORT  (Beenden: Fenster schließen oder Ctrl+C)"
( sleep 1; open "http://localhost:$PORT" ) &
python3 -m http.server $PORT
