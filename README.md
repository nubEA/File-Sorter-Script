# Auto Download Sorter 🗂️

This tool automatically organizes your `Downloads` folder by moving newly downloaded files into categorized subfolders based on their file type (Images, Videos, Documents, etc.). It uses a Bash script and `incron` to watch for new files and trigger sorting in real-time.

---

## 📁 Features

- Automatically sorts files into:
  - Images (`.png`, `.jpg`, `.jpeg`, etc.)
  - Videos (`.mp4`, `.mkv`, etc.)
  - Audios (`.mp3`, `.wav`, etc.)
  - Documents (`.pdf`, `.txt`, `.docx`, etc.)
  - Archives (`.zip`, `.rar`, `.gz`, etc.)
  - Presentations (`.pptx`)
  - Others (anything else)
- Triggered instantly on new file creation or move
- Works in the background using `incron`

---

## ⚙️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/auto-download-sorter.git
cd auto-download-sorter
```

### 2. Install incron
```bash
sudo dnf install incron
sudo systemctl enable --now incrond
```
### 3. Make the Script Executable
```bash
chmod +x sort_download.sh
```

### 4. Add the Script to Your incrontab
```bash
incrontab -e
```
Add this line (replace /absolute/path/to/ if needed):
```
/home/YOUR_USERNAME/Downloads IN_CREATE,IN_CLOSE_WRITE,IN_MOVED_TO /absolute/path/to/sort_download.sh %w%f
```
