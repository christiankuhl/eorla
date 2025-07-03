![Flutter Test](https://github.com/christiankuhl/eorla/actions/workflows/testing.yaml/badge.svg)

# Eorla

This is an app to simulate dice rolls for the German table top role playing game "Das Schwarze Auge" (The Dark Eye) version 5.

Its character format is compatible with the json format used by the excellent DSA character creator [Optolith](https://optolith.app/de).

It currently targets Android and the web as deployment platforms. You can test out the web version [here](https://christiankuhl.github.io/eorla/).

| ![](https://github.com/christiankuhl/eorla/.github/home_screen.png) | ![](https://github.com/christiankuhl/eorla/.github/skill_roll.png) | ![](https://github.com/christiankuhl/eorla/.github/combat.png) | ![](https://github.com/christiankuhl/eorla/.github/characters.png) |
|-----------------|-----------------|-----------------|-----------------|
| Home Screen     | Skill roll      | Combat menu     | Character import|


## Building the project / Contributing

The project is a bog standard flutter repository and should require almost no special treatment. There are some proprietary texts stored in the private repository referenced by `/database/`, but the project should build and run just fine without them.

If you do want to contribute, just do the usual: fork the repo and send us a pull request.

If you want to contribute to the database, please [get in touch](mailto:christian.kuhl84@gmail.com). In that case, one needs to run the build script `dart run build_runner build` for any changes to take effect.

