#!/usr/bin/env python3
import subprocess
import tkinter as tk
from tkinter import messagebox, scrolledtext
import sys
import os

class SixtySevenExecuter(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("67 EXECUTER")
        self.geometry("600x450")
        self.configure(bg="#0A192F")
        
        # Title Label
        title_label = tk.Label(
            self, 
            text="67 EXECUTER", 
            font=("Helvetica", 20, "bold"), 
            fg="#FFFFFF", 
            bg="#0A192F"
        )
        title_label.pack(pady=(20, 10))
        
        # Script Input Area
        self.script_text = scrolledtext.ScrolledText(
            self, 
            width=70, 
            height=15, 
            font=("Courier New", 11), 
            bg="#1E3A5F", 
            fg="#00FF00", 
            insertbackground="#00FF00"
        )
        self.script_text.pack(padx=20, pady=10)
        
        # Button Frame
        btn_frame = tk.Frame(self, bg="#0A192F")
        btn_frame.pack(pady=10)
        
        # Execute Button
        self.btn_execute = tk.Button(
            btn_frame, 
            text="Execute", 
            command=self.execute_script, 
            font=("Helvetica", 12, "bold"), 
            bg="#1E3A5F", 
            fg="#FFFFFF", 
            activebackground="#2C536E", 
            width=15
        )
        self.btn_execute.grid(row=0, column=0, padx=10)
        
        # Clear Button
        self.btn_clear = tk.Button(
            btn_frame, 
            text="Clear", 
            command=self.clear_textbox, 
            font=("Helvetica", 12, "bold"), 
            bg="#1E3A5F", 
            fg="#FFFFFF", 
            activebackground="#2C536E", 
            width=15
        )
        self.btn_clear.grid(row=0, column=1, padx=10)
        
        # Inject Button
        self.btn_inject = tk.Button(
            btn_frame, 
            text="Inject", 
            command=self.inject_dylib, 
            font=("Helvetica", 12, "bold"), 
            bg="#1E3A5F", 
            fg="#FFFFFF", 
            activebackground="#2C536E", 
            width=15
        )
        self.btn_inject.grid(row=0, column=2, padx=10)
        
        # Status Label (for injection confirmation)
        self.status_label = tk.Label(
            self, 
            text="", 
            font=("Helvetica", 10), 
            fg="#00FF00", 
            bg="#0A192F"
        )
        self.status_label.pack(pady=(5, 0))
    
    def execute_script(self):
        script = self.script_text.get("1.0", tk.END).strip()
        if not script:
            messagebox.showwarning("Warning", "No script to execute!")
            return
        
        # Simulate execution by logging or calling dylib via subprocess
        try:
            result = subprocess.run(
                ["./lib67inject.dylib", "--execute", script],
                capture_output=True, 
                text=True, 
                timeout=10
            )
            if result.returncode == 0:
                messagebox.showinfo("Success", "Script executed successfully!")
            else:
                messagebox.showerror("Error", f"Execution failed:\n{result.stderr}")
        except FileNotFoundError:
            messagebox.showerror("Error", "lib67inject.dylib not found!")
        except subprocess.TimeoutExpired:
            messagebox.showerror("Timeout", "Execution timed out.")
    
    def clear_textbox(self):
        self.script_text.delete("1.0", tk.END)
    
    def inject_dylib(self):
        # Check if Roblox is running
        try:
            check_roblox = subprocess.run(
                ["pgrep", "-f", "Roblox"], 
                capture_output=True, 
                text=True
            )
            if check_roblox.returncode != 0:
                messagebox.showwarning("Not Running", "Roblox is not currently running.")
                return
            
            # Perform injection simulation
            status_msg = "Injected 67 executer!"
            self.status_label.config(text=status_msg, fg="#00FF00")
            
            # Flash effect
            self.after(2000, lambda: self.status_label.config(text=""))
            
        except Exception as e:
            messagebox.showerror("Injection Error", str(e))


if __name__ == "__main__":
    app = SixtySevenExecuter()
    app.mainloop()
