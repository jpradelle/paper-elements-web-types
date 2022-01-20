# Web-Types for Material Web components
Web-Types is a framework-agnostic format aimed at providing IDEs and other tools with the metadata 
information about the contents of a component library. Its powerful name patterns allow encoding 
information about web framework syntax or customizing code completion suggestions for large icon 
libraries in the IDEs that support Web-Types.

See [web-types](https://github.com/JetBrains/web-types) project

# paper-elements-web-types
`paper-elements-web-types` contains Web-Types definition of
[Polymer Elements](https://www.webcomponents.org/author/PolymerElements) components.

## Getting started with lit
To use it when working with lit you need [`lit-web-types`](https://github.com/jpradelle/lit-web-types)
extra dependency to enable autocompletion on your project.
```bash
npm i lit-web-types paper-elements-web-types -D
```

If using IntelliJ or WebStorm, IDE restart might be needed after install to enable autocomplete.

## Getting started with polymer
To use it when working with polymer you need [`polymer-web-types`](https://github.com/jpradelle/polymer-web-types)
extra dependency to enable autocompletion on your project.
```bash
npm i polymer-web-types paper-elements-web-types -D
```

If using IntelliJ or WebStorm, IDE restart might be needed after install to enable autocomplete.

# Contributing
Steps to update web-types definitions of `paper-elements-web-types` package:

#### Update sources
`src/gen` folder contains generated sources by `web-component-analyser`, should not be updated
by hand, only via generator:
```bash
npm run web-types
```

Other sources in `src` can be updated by hand.

#### Build template to web-types
```bash
npm run build
```

#### Release
```bash
npm version patch && npm publish && git push && git push --tags
```