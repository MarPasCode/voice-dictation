const http = require('http');
const fs = require('fs');
const path = require('path');

// Picks the port to listen on: env var override, then config.json, then a hardcoded fallback.
function resolvePort() {
  if (process.env.DICT_PORT) return Number(process.env.DICT_PORT);
  try {
    const config = JSON.parse(fs.readFileSync(path.join(__dirname, 'config.json'), 'utf8'));
    if (config.port) return Number(config.port);
  } catch (e) {}
  return 7778;
}

const PORT = resolvePort();

// Maps file extensions to the Content-Type header served for them.
const contentTypes = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.svg': 'image/svg+xml; charset=utf-8'
};

// Serves files from this folder as static content; defaults to index.html for the root path.
const server = http.createServer((req, res) => {
  const urlPath = req.url === '/' ? '/index.html' : req.url;
  const filePath = path.join(__dirname, urlPath);

  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end('Not found');
      return;
    }
    const ext = path.extname(filePath);
    res.writeHead(200, { 'Content-Type': contentTypes[ext] || 'text/plain' });
    res.end(data);
  });
});

server.listen(PORT, 'localhost', () => {
  console.log(`Voice dictation running at http://localhost:${PORT}`);
});
