import {EditorState} from "prosemirror-state"
import {EditorView} from "prosemirror-view"
import {Schema, DOMParser} from "prosemirror-model"
import {schema, defaultMarkdownParser,
        defaultMarkdownSerializer} from "prosemirror-markdown"
import {addListNodes} from "prosemirror-schema-list"
import {exampleSetup} from "prosemirror-example-setup"

// Mix the nodes from prosemirror-schema-list into the basic schema to
// create a schema with list support.
const mySchema = new Schema({
  nodes: addListNodes(schema.spec.nodes, "paragraph block", "block"),
  marks: schema.spec.marks
})

export class Editor {
    constructor(id) {
        this.view = new EditorView(document.querySelector(id), {
            state: EditorState.create({
                doc: defaultMarkdownParser.parse(document.querySelector("#content").value),
                plugins: exampleSetup({schema: mySchema})
        })})
    }
    get value() {
        return defaultMarkdownSerializer.serialize(this.view.state.doc)
    }
}
