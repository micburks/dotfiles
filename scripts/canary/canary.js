#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const util = require('util');
const {execSync} = require('child_process');
const json5 = require('json5');
const del = require('del');

const version = process.argv[2];
if (!version) {
  console.log('must specific a canary version to install - e.g. `canary 0.0.0-canary.ed79452.0`');
  process.exit(0);
}

const ls = util.promisify(fs.readdir);
const read = util.promisify(fs.readFile);
const write = util.promisify(fs.writeFile);

const rushJson = '/Users/mburks/Code/uber/monorepos/uber-fusionjs/rush.json';
const packageJson = path.resolve('package.json');
const yarnLock = path.resolve('yarn.lock');

(async function init() {
  const rush = json5.parse(
    await read(rushJson)
  );
  const packages = rush.projects.map(p => p.packageName);
  const pkg = JSON.parse(
    await read(packageJson)
  );

  packages.forEach(p => {
    if (pkg.dependencies && pkg.dependencies[p]) {
      pkg.dependencies[p] = version;
    }
    if (pkg.devDependencies && pkg.devDependencies[p]) {
      pkg.devDependencies[p] = version;
    }
  });

  await write(
    packageJson,
    JSON.stringify(pkg, null, 2)
  );
  await del(yarnLock);
  console.log('canary versions updated - run `yarn install`');
})();
