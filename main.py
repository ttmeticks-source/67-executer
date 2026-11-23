#!/usr/bin/env python3
import subprocess
import tkinter as tk
from tkinter import messagebox, scrolledtext
import os

class SixtySevenExecuter(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("67 EXECUTER")
        self.geometry("650x500")
        self.configure(bg="#0A192F")
        self.resizable(False, False)

        # --- Header Section ---
        header_frame = tk.Frame(self, bg="#0A192F", height=60)
        header_frame.pack(fill=tk.X, padx=10, pady=(10, 0))
        
        # Icon Placeholder (Simple Text Icon for now, can be replaced with Image)
        icon_label = tk.Label(header_frame, text="67", font=("Helvetica", 24, "bold"), fg="#FFFFFF", bg="#0A192F")
        icon_label.pack(side=tk.LEFT, padx=(0, 10))
        
        title_label = tk.Label(header_frame, text="EXECUTER", font=("Helvetica", 24, "bold"), fg="#FFFFFF", bg="#0A192F")
        title_label.pack(side=tk.LEFT)

        # --- Script Input Area ---
        self.script_text = scrolledtext.ScrolledText(
            self, 
            width=80, 
            height=18, 
            font=("Courier New", 11), 
            bg="#1E3A5F", 
            fg="#00FF00", 
            insertbackground="#00FF00",
            padx=10,
            pady=10
        )
        self.script_text.pack(padx=20, pady=10, fill=tk.BOTH, expand=True)
        self.script_text.insert(tk.END, "-- Paste your script here\nprint('Hello from 67 Executer')")

        # --- Button Frame ---
        btn_frame = tk.Frame(self, bg="#0A192F")
        btn_frame.pack(pady=10)

        # Buttons
        self.btn_execute = tk.Button(btn_frame, text="Execute", command=self.execute_script, font=("Helvetica", 12, "bold"), bg="#1E3A5F", fg="#FFFFFF", activebackground="#2C536E", width=15, relief=tk.FLAT)
        self.btn_clear = tk.Button(btn_frame, text="Clear", command=self.clear_textbox, font=("Helvetica", 12, "bold"), bg="#1E3A5F", fg="#FFFFFF", activebackground="#2C536E", width=15, relief=tk.FLAT)
        self.btn_inject = tk.Button(btn_frame, text="Inject", command=self.inject_dylib, font=("Helvetica", 12, "bold"), bg="#1E3A5F", fg="#FFFFFF", activebackground="#2C536E", width=15, relief=tk.FLAT)

        self.btn_execute.grid(row=0, column=0, padx=10)
        self.btn_clear.grid(row=0, column=1, padx=10)
        self.btn_inject.grid(row=0, column=2, padx=10)

        # --- Status Label ---
        self.status_label = tk.Label(self, text="", font=("Helvetica", 10, "italic"), fg="#00FF00", bg="#0A192F")
        self.status_label.pack(pady=(5, 10))

    def execute_script(self):
        script = self.script_text.get("1.0", tk.END).strip()
        if not script:
            messagebox.showwarning("Warning", "No script to execute!")
            return
        
        # Simulate execution logic
        # In a real scenario, this would pass the script to the dylib
        print(f"Executing script:\n{script}")
        messagebox.showinfo("Success", "Script sent to executor core.")

    def clear_textbox(self):
        self.script_text.delete("1.0", tk.END)

    def inject_dylib(self):
        # Check if Roblox is running
        try:
            # Check for both Intel and Apple Silicon Roblox processes
            check_roblox = subprocess.run(["pgrep", "-f", "Roblox"], capture_output=True, text=True)
            
            if check_roblox.returncode != 0:
                messagebox.showwarning("Not Running", "Roblox is not currently running.\nPlease open Roblox first.")
                return
            
            # Perform injection simulation
            status_msg = "Injected 67 executer!"
            self.status_label.config(text=status_msg, fg="#00FF00")
            
            # Visual feedback
            self.btn_inject.config(bg="#00FF00", fg="#0A192F")
            self.after(1000, lambda: self.btn_inject.config(bg="#1E3A5F", fg="#FFFFFF"))
            self.after(2000, lambda: self.status_label.config(text=""))
            
            print("Injection successful.")
            
        except Exception as e:
            messagebox.showerror("Injection Error", str(e))

if __name__ == "__main__":
    app = SixtySevenExecuter()
    app.mainloop()
