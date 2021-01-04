import resolve from "@rollup/plugin-node-resolve";
import babel from "@rollup/plugin-babel";
import { terser } from "rollup-plugin-terser";
import typescript from "rollup-plugin-typescript";

const plugins = [
  babel(),
  resolve(),
  typescript(),
];

if (process.env.production) {
  plugins.push(terser());
}

export default {
  input: "src/index.ts",
  output: {
    file: "dist/index.js",
    format: "iife",
  },
  plugins,
};
