const fs = require('fs');

const srcDirPath = '../benadme-blog-git/content/blog';
const outputDirPath = 'content/blog';
const maxFiles = -1;

let dir = fs.opendirSync(srcDirPath);
var count = 0;
while ((dirEnt = dir.readSync()) != null) {
    if (!dirEnt.isFile())
        continue;
    console.log(dirEnt.name);
    let content = fs.readFileSync(srcDirPath + "/" + dirEnt.name,
        { encoding: 'utf8' });
    var headMatch = content.match(/\+\+\+\n(?<front>.*\n)\+\+\+\n/s);
    if (headMatch && headMatch.groups) {
        var front = headMatch.groups.front;
        front = front.replace(/type = .*\n/, '');
        front = front.replace(/url = "(?<urlval>.*)"/, 'permalink = "$<urlval>/"');
        console.log(front);
        let outContent = content.replace(
            /\+\+\+\n.*\n\+\+\+\n/s,
            '---toml\n' + front + '---\n');
        let outFd = fs.openSync(outputDirPath + '/' + dirEnt.name, 'w');
        fs.writeSync(outFd, outContent, null, 'utf8');
        fs.closeSync(outFd);
    }

    count++;
    if (maxFiles > 0 && count >= maxFiles)
        break;
}