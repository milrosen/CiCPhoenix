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
import {Editor} from "./editor"
import socket from "./type_check_socket.js"


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let Hooks = {};

function debounce(func, timeout = 300){
    let timer;
    return (...args) => {
      clearTimeout(timer);
      timer = setTimeout(() => { func.apply(this, args); }, timeout);
    };
}


Hooks.GenProseMirror = {
    mounted() {
        let typeChannel = socket.channel("document:420", {})
            typeChannel.join()

        typeChannel.on("type_check", payload => {
            proofs = payload.body
            outboxes = document.querySelectorAll(".cm-editor")


            proofs.forEach((proof, index) => {
                outbox = outboxes[index]
                classname = "ok"
                if (proof.error) {
                    classname = "error"
                    proof = proof.error
                } else {
                    proof = proof.ok.filter(x => x.length > 0).join("\n")
                }
                if (!outbox.lastChild.className.includes("outbox")) {
                    outbox.insertAdjacentHTML('beforeend', `<p>${proof}</p>`)
                } else {
                    out = outbox.lastChild
                    out.innerHTML = proof
                }
                
                outbox.lastChild.className =`${classname} outbox`
            });
        })
            
        const editor = new Editor('#editor', (before, after) => {
            typeChannel.push("code_update", {body: after})
        })

        const content = document.querySelector("#content")
        window.setTimeout(() => {
            console.log(editor.code)
            typeChannel.push("code_update", {body: editor.code})
        }, 0) 
    
        this.el.addEventListener("keydown", debounce(() => {
            content.value = editor.value;
        }), 300)
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

