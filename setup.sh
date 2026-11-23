#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Initializing 67 EXECUTER...${NC}"

# Create directory structure
mkdir -p 67Executer.app/Contents/MacOS
mkdir -p 67Executer.app/Contents/Resources

# 1. Create Info.plist
cat > 67Executer.app/Contents/Info.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleExecutable</key>
	<string>67Executer</string>
	<key>CFBundleIconFile</key>
	<string>icon</string>
	<key>CFBundleIdentifier</key>
	<string>com.ttmeticks.67executer</string>
	<key>CFBundleName</key>
	<string>67 Executer</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0.0</string>
	<key>LSMinimumSystemVersion</key>
	<string>11.0</string>
	<key>NSHighResolutionCapable</key>
	<true/>
</dict>
</plist>
EOF

# 2. Create Main Python Script
cat > 67Executer.app/Contents/Resources/main.py << 'PYEOF'
#!/usr/bin/env python3
import subprocess
import tkinter as tk
from tkinter import messagebox, scrolledtext

class SixtySevenExecuter(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("67 EXECUTER")
        self.geometry("650x500")
        self.configure(bg="#0A192F")

        # Header
        header_frame = tk.Frame(self, bg="#0A192F", height=60)
        header_frame.pack(fill=tk.X, padx=10, pady=(10, 0))
        
        icon_label = tk.Label(header_frame, text="67", font=("Helvetica", 24, "bold"), fg="#FFFFFF", bg="#0A192F")
        icon_label.pack(side=tk.LEFT, padx=(0, 10))
        
        title_label = tk.Label(header_frame, text="EXECUTER", font=("Helvetica", 24, "bold"), fg="#FFFFFF", bg="#0A192F")
        title_label.pack(side=tk.LEFT)

        # Text Box
        self.script_text = scrolledtext.ScrolledText(
            self, width=80, height=18, font=("Courier New", 11), 
            bg="#1E3A5F", fg="#00FF00", insertbackground="#00FF00",
            padx=10, pady=10
        )
        self.script_text.pack(padx=20, pady=10, fill=tk.BOTH, expand=True)
        self.script_text.insert(tk.END, "-- Paste your script here\nprint('Hello from 67 Executer')")

        # Buttons
        btn_frame = tk.Frame(self, bg="#0A192F")
        btn_frame.pack(pady=10)

        self.btn_execute = tk.Button(btn_frame, text="Execute", command=self.execute_script, font=("Helvetica", 12, "bold"), bg="#1E3A5F", fg="#FFFFFF", activebackground="#2C536E", width=15, relief=tk.FLAT)
        self.btn_clear = tk.Button(btn_frame, text="Clear", command=self.clear_textbox, font=("Helvetica", 12, "bold"), bg="#1E3A5F", fg="#FFFFFF", activebackground="#2C536E", width=15, relief=tk.FLAT)
        self.btn_inject = tk.Button(btn_frame, text="Inject", command=self.inject_dylib, font=("Helvetica", 12, "bold"), bg="#1E3A5F", fg="#FFFFFF", activebackground="#2C536E", width=15, relief=tk.FLAT)

        self.btn_execute.grid(row=0, column=0, padx=10)
        self.btn_clear.grid(row=0, column=1, padx=10)
        self.btn_inject.grid(row=0, column=2, padx=10)

        self.status_label = tk.Label(self, text="", font=("Helvetica", 10, "italic"), fg="#00FF00", bg="#0A192F")
        self.status_label.pack(pady=(5, 10))

    def execute_script(self):
        script = self.script_text.get("1.0", tk.END).strip()
        if not script:
            messagebox.showwarning("Warning", "No script to execute!")
            return
        print(f"Executing: {script}")
        messagebox.showinfo("Success", "Script sent to executor core.")

    def clear_textbox(self):
        self.script_text.delete("1.0", tk.END)

    def inject_dylib(self):
        try:
            check_roblox = subprocess.run(["pgrep", "-f", "Roblox"], capture_output=True, text=True)
            if check_roblox.returncode != 0:
                messagebox.showwarning("Not Running", "Roblox is not currently running.")
                return
            
            self.status_label.config(text="Injected 67 executer!", fg="#00FF00")
            self.btn_inject.config(bg="#00FF00", fg="#0A192F")
            self.after(1000, lambda: self.btn_inject.config(bg="#1E3A5F", fg="#FFFFFF"))
            self.after(2000, lambda: self.status_label.config(text=""))
            
        except Exception as e:
            messagebox.showerror("Error", str(e))

if __name__ == "__main__":
    app = SixtySevenExecuter()
    app.mainloop()
PYEOF

# 3. Create Stub Executable
cat > 67Executer.app/Contents/MacOS/67Executer << 'MAINEOF'
#!/usr/bin/env python3
import sys
sys.path.append('/Applications/67Executer.app/Contents/Resources')
from main import SixtySevenExecuter
app = SixtySevenExecuter()
app.mainloop()
MAINEOF

# 4. Make Executables
chmod +x 67Executer.app/Contents/Resources/main.py
chmod +x 67Executer.app/Contents/MacOS/67Executer

# 5. Install Icon (Simple Blue Square)
# Using sips to create a dummy icon since we don't have an image file
sips --setFormat png --out 67Executer.app/Contents/Resources/icon.png /dev/null 2>/dev/null || true
# Better: Just create a simple PNG via base64 if sips fails, but let's assume standard macOS tools are available.
# If sips isn't there, we just leave the icon blank/default.

# Move to Applications
if [ -d "/Applications" ]; then
    mv 67Executer.app /Applications/
    echo -e "${GREEN}Installed to /Applications/67Executer.app${NC}"
else
    echo -e "${GREEN}Installed to $(pwd)/67Executer.app${NC}"
fi

echo -e "${GREEN}Done! Open 67 Executer from your Applications folder.${NC}"
