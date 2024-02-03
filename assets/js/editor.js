import {EditorState} from "prosemirror-state"
import {EditorView} from "prosemirror-view"
import {schema, defaultMarkdownParser,
        defaultMarkdownSerializer} from "prosemirror-markdown"
import {exampleSetup} from "prosemirror-example-setup"

// Mix the nodes from prosemirror-schema-list into the basic schema to
// create a schema with list support.

export class Editor {
    constructor(id) {
        this.view = new EditorView(document.querySelector(id), {
            state: EditorState.create({
                doc: defaultMarkdownParser.parse(document.querySelector("#content").value),
                plugins: exampleSetup({schema})
        })})
    }
    get value() {
        return defaultMarkdownSerializer.serialize(this.view.state.doc)
    }
}
