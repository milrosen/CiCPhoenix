// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import hljs from "highlight.js"
import {Editor} from "./editor"


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

function updateLineNumbers(value) {
    const lineNumberText = document.querySelector("#line-numbers");
    if (!lineNumberText) return;
    
    const lines = value.split("\n");

    const numbers = lines.map((_, index) => index+1).join("\n") + "\n"

    lineNumberText.value = numbers;
};

let Hooks = {};

Hooks.Highlight = {
    mounted() {
        let codeBlock = this.el.querySelector("pre code");
        if (codeBlock == null) return;

        trimmed = this.trimCodeBlock(codeBlock);
        hljs.highlightElement(trimmed)
        updateLineNumbers(trimmed.textContent)
    },

    trimCodeBlock(codeBlock) {
        const lines = codeBlock.textContent.split("\n");
        if (lines.length > 2) {
            lines.shift();
            lines.pop();
        }
        codeBlock.textContent = lines.join("\n");
        return codeBlock;
    }
};

function debounce(func, timeout = 300){
    let timer;
    return (...args) => {
      clearTimeout(timer);
      timer = setTimeout(() => { func.apply(this, args); }, timeout);
    };
}

Hooks.GenProseMirror = {
    mounted() {
        const editor = new Editor('#editor')
        const content = document.querySelector("#content")
    
        this.el.addEventListener("keydown", debounce(() => {
            console.log(editor.value)
            content.value = editor.value;
        }), 300)
    }
}

Hooks.UpdateLineNumbers = {
    mounted() {
        const lineNumberText = document.querySelector("#line-numbers");

        this.el.addEventListener("input", () => {
            updateLineNumbers(this.el.value);
        })

        this.el.addEventListener("keydown", (e) => {
            if (e.key == "Tab") {
                e.preventDefault()
                var start = this.el.selectionStart;
                var end = this.el.selectionEnd;

                this.el.value= this.el.value.substring(0, start) + "\t" + this.el.value.substring(end)
                this.el.selectionStart = this.el.selectionEnd = start + 1;
            }
        })

        this.el.addEventListener("scroll", () => {
            lineNumberText.scrollTop = this.el.scrollTop
        })

        this.handleEvent("clear-textarea", () => {
            this.el.value = "";
            lineNumberText.value = "1\n";
        })

        updateLineNumbers(this.el.value);
    }  
}

let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

