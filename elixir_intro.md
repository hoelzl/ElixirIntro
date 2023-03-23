# Einführung in Elixir

- Elixir ist eine funktional-imperative Programmiersprache, die auf der Erlang
  VM (BEAM) ausgeführt wird.
- Sie wurde 2012 von José Valim entwickelt und ist eine Mischung aus Erlangs
  Funktionalität und Rubys Syntax.
- Elixir ist eine dynamische, quelloffene, hochskalierbare Sprache, die für die
  Entwicklung von verteilten, hochverfügbaren und niederlatenz Systemen
  verwendet wird.
- Elixir bietet eine einzigartige Kombination aus Funktionalität und
  Productivity, was es zu einer sehr attraktiven Wahl für viele Anwendungsfälle
  macht.
- Elixir stellt eine Reihe von Funktionen bereit, darunter Pattern Matching,
  Immutability, Hot Code Reloading und vieles mehr.
- Elixir ist eine sehr leistungsstarke Sprache, die in der Lage ist, sehr
  performante und skalierbare Systeme zu entwickeln.

## Vorteile und Nachteile

### Vorteile:

- Skalierbarkeit und Nebenläufigkeit
- Fehlerhafte Toleranz
- Einfache Syntax

### Nachteile:

- Lernkurve für funktionale Programmierkonzepte
- Begrenzte Tooling- und Community-Unterstützung
- Niedrige Performance für rechenintensive Aufgaben

## Funktionale und Nebenläufige Programmierung

- Funktionale Programmierkonzepte
- Anonyme Funktionen
- Funktionen höherer Ordnung
- Nebenläufigkeit in Elixir
- Prozesse und Nachrichtenübermittlung

## Hohe Verfügbarkeit und Fehlertoleranz

- Verteilte Systeme
- Das Actor-Modell
- Supervision Trees

## Grundlagen von Elixir

### Datentypen

- Zahlen
- Atome
- Strings
- Tupel
- Listen
- Maps
- Binärdaten


### Grundlegende Operationen:

- Arithmetik
- Vergleichsoperationen
- Logik
- Bitweise

## Mix

- Elixirs Build-Tool
- Ein neues Projekt erstellen: `mix new my_project`
- Kompilieren und Ausführen von Code:
  - `mix compile`
  - `mix run`
  - `iex -S mix` (interaktiv)
- Ausführen von Tests: `mix test`
- Verwalten von Abhängigkeiten: `mix deps.get`
- Erstellen von Releases: `mix release`
- Dokumentation generieren: `mix docs`

## Funktionen, Variablen und Module

- Definieren von Modulen
- Definieren von Funktionen
- Definieren von Variablen
- Private Funktionen
- Funktionsargumente und Pattern-Matching
- Modulattribute

## Kontrollstrukturen


- Bedingte Anweisungen
- Case-Anweisungen
- Rekursion
- Schleifen
- Exceptions

## Collections (Listen, Maps, Sets)

- Listen
- Maps
- Sets

## Das Enum-Modul

- Eingebautes Modul zum Arbeiten mit Sammlungen
- Häufig verwendete Funktionen
- Beispiele für die Verwendung

## Der Pipe-Operator

- Verkettung von Funktionsaufrufen
- Verbesserung der Code-Lesbarkeit
- Verwendung mit anderen Operatoren

## Comprehensions

- Erstellen von Listen und Maps mit Comprehensions

## Structures

- Definition von Structs
- Verwendung von Structs

## Protokolle

- Erstellen von Protokollen
- Implementieren von Protokollen
- Verwenden von Protokollen

## Prozesse

- Prozesse in Elixir
- Erstellen und Verwalten von Prozessen
- Senden und Empfangen von Nachrichten
- Prozessregistrierung
