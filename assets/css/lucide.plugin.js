// Embeds Lucide icons (https://lucide.dev) into your app.css bundle
// See your `CoreComponents.Icon.icon/1` for more information.
const fs = require("fs");
const path = require("path");
const plugin = require("tailwindcss/plugin");

const svgStyle = ({ prefix, name, content, size }) => ({
  [`--${prefix}-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
  "-webkit-mask": `var(--${prefix}-${name})`,
  mask: `var(--${prefix}-${name})`,
  "background-color": "currentColor",
  "vertical-align": "middle",
  display: "inline-block",
  width: size,
  height: size,
});

module.exports = plugin(function ({ matchComponents, theme }) {
  let iconsDir = path.join(__dirname, "../../deps/lucide/icons");

  const values = fs.readdirSync(iconsDir).reduce((iconsAcc, file) => {
    if (file.endsWith(".svg")) {
      const name = path.basename(file, ".svg");
      iconsAcc[name] = { name, fullPath: path.join(iconsDir, file) };
      return iconsAcc;
    } else {
      return iconsAcc;
    }
  }, {});

  matchComponents(
    {
      lucide: ({ name, fullPath }) => {
        const content = fs
          .readFileSync(fullPath)
          .toString()
          .replace(/\r?\n|\r/g, "")
          // Remove width and height attributes we only need viewBox
          .replace('width="24"', "")
          .replace('height="24"', "");

        const size = theme("spacing.6");
        return svgStyle({ prefix: "lucide", name, content, size });
      },
    },
    { values },
  );
});
