import 'phoenix_html';
import '../css/app.css';

import { Hooks as BackpexHooks } from './../../deps/backpex/assets/js/backpex.js';
import { LiveSocket } from 'phoenix_live_view';
import { Socket } from 'phoenix';
import { getHooks } from 'live_vue';
import liveVueApp from '../vue';
import topbar from 'topbar';

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute('content');

const VueHooks = getHooks(liveVueApp);

const liveSocket = new LiveSocket('/live', Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
  hooks: { ...VueHooks, ...BackpexHooks },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: '#29d' }, shadowColor: 'rgba(0, 0, 0, .3)' });
window.addEventListener('phx:page-loading-start', (_info) => topbar.show(300));
window.addEventListener('phx:page-loading-stop', (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
