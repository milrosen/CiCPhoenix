import {parser} from "./parser.js"
import {foldNodeProp, foldInside, indentNodeProp} from "@codemirror/language"
import {styleTags, tags as t} from "@lezer/highlight"
import {LRLanguage} from "@codemirror/language"
import {LanguageSupport} from "@codemirror/language"

let parserWithMetadata = parser.configure({
    props: [
      styleTags({
        Identifier: t.variableName,
        "( )": t.paren,
        "->": t.bool,
      //   "\\/ \\": t.controlOperator
      }),
      indentNodeProp.add({
        Application: context => context.column(context.node.from) + context.unit
      }),
      foldNodeProp.add({
        Application: foldInside
      })
    ]
})

export const exampleLanguage = LRLanguage.define({
  parser: parserWithMetadata
})

export function example() {
    return new LanguageSupport(exampleLanguage)
  }
  
// export default () => console.log(exampleLanguage)



