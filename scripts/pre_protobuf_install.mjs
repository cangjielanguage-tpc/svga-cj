// scripts/pre-install.mjs
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.resolve(__dirname, '..');

const PROTOBUF_ZIP_URL = 'https://raw.gitcode.com/Cangjie-TPC/protobuf4cj/archive/refs/heads/v1.0.3.zip';
const PROTOBUF_ZIP_TEMP_PATH = path.join(PROJECT_ROOT, 'v1.0.3.zip');

function downloadAndExtract(label, zipUrl, tempPath, extractPath) {
    console.log(`Downloading ${label} package...`);

    execSync(`curl -L -o ${tempPath} ${zipUrl}`, {
        stdio: 'inherit',
        cwd: PROJECT_ROOT
    });

    if (fs.existsSync(tempPath)) {
        if (fs.statSync(tempPath).size === 0) {
            console.error(`${label} ZIP file is empty, download failed`);
            fs.unlinkSync(tempPath);
            process.exit(1);
        }
    } else {
        console.error(`${label} ZIP file not found`);
        process.exit(1);
    }

    try {
        console.log(`Extracting ${label} package...`);

        if (process.platform === 'win32') {
            execSync(
                `powershell -Command "Expand-Archive -Path '${tempPath}' -DestinationPath '${extractPath}' -Force"`,
                {
                    stdio: 'inherit',
                    cwd: PROJECT_ROOT
                }
            );
        } else {
            execSync(`unzip -o ${tempPath} -d ${extractPath}`, {
                stdio: 'inherit',
                cwd: PROJECT_ROOT
            });
        }
    } finally {
        if (fs.existsSync(tempPath)) {
            fs.unlinkSync(tempPath);
        }
    }
}

const EXTRACT_PATH = path.join(PROJECT_ROOT, 'protobuf');
const needsDownload = !fs.existsSync(EXTRACT_PATH) || fs.readdirSync(EXTRACT_PATH).length === 0;

if (needsDownload) {
    console.log('Downloading required files...');

    try {
        fs.mkdirSync(EXTRACT_PATH, { recursive: true });

        downloadAndExtract(
            'PROTOBUF',
            PROTOBUF_ZIP_URL,
            PROTOBUF_ZIP_TEMP_PATH,
            EXTRACT_PATH
        );

        flattenProtobufDir(EXTRACT_PATH);

        console.log(
            `All files downloaded and extracted successfully to ${EXTRACT_PATH}`
        );
    } catch (error) {
        console.error(
            `Download or extraction failed: ${error.message}`
        );

        if (fs.existsSync(PROTOBUF_ZIP_TEMP_PATH)) {
            fs.unlinkSync(PROTOBUF_ZIP_TEMP_PATH);
        }

        process.exit(1);
    }
} else {
    console.log(
        `Directory ${EXTRACT_PATH} already exists, skipping.`
    );
}

function flattenProtobufDir(extractPath) {
    const entries = fs.readdirSync(extractPath);

    if (entries.length !== 1) {
        return;
    }

    const rootDir = path.join(extractPath, entries[0]);

    if (!fs.statSync(rootDir).isDirectory()) {
        return;
    }

    const targetPath = path.join(rootDir, 'src', 'protobuf');

    if (!fs.existsSync(targetPath) || !fs.statSync(targetPath).isDirectory()) {
        console.warn('Target src/protobuf not found, skipping flatten.');
        return;
    }

    console.log(`Flattening ${targetPath} -> ${extractPath}`);

    // 把 src/protobuf 下的内容移动到 protobuf/
    for (const item of fs.readdirSync(targetPath)) {
        const srcItem = path.join(targetPath, item);
        const destItem = path.join(extractPath, item);

        fs.renameSync(srcItem, destItem);
    }

    fs.rmSync(rootDir, {
        recursive: true,
        force: true
    });
}