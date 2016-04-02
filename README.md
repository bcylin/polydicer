# Polydicer

A web version of Polydice business card.

![screenshot](https://raw.githubusercontent.com/bcylin/polydicer/develop/source/images/screenshot.png)

## Setup

* Install required gems:

```
bundle install
```

* Set up your info in `me.json`

```
bundle exec rake init
```

* Start up a local web server at `http://localhost:4567/`

```
bundle exec middleman server
```

## Deploy to GitHub Pages

* Fork this repository and add it as a remote of your GitHub `$USERNAME`.

```sh
git remote add $USERNAME git://github.com/$USERNAME/polydicer.git
```

* If you have [hub](https://hub.github.com/) installed, simply run:

```
hub fork
```

* Build and deploy the page to `gh-pages` of your repository:

```
bundle exec middleman deploy
```

## Contributors

* [@jiajhenbee](https://github.com/jiajhenbee), design of the physical card and all the CSS effects
* [@frozenfung](https://github.com/frozenfung), code support

Special thanks to [@amelieyeh](https://github.com/amelieyeh) for the help with CSS troubleshooting.

## Contact

[![Twitter](https://img.shields.io/badge/twitter-@bcylin-blue.svg?style=flat)](https://twitter.com/bcylin)

## License

`Polydice` and `iCook` are trademarks of [Polydice, Inc.](https://polydice.com/) Please refer to the guidelines on [iCook Newsroom](https://newsroom.icook.tw/downloads).

The source code is released under the MIT license. See [LICENSE](https://github.com/bcylin/polydicer/blob/develop/LICENSE) for details.
