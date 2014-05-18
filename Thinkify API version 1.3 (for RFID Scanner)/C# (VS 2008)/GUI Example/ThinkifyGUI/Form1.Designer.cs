

namespace ThinkifyGUI
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
               
            }
            
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.chkReading = new System.Windows.Forms.CheckBox();
            this.lblNumReads = new System.Windows.Forms.Label();
            this.txtReplys = new System.Windows.Forms.TextBox();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnVersion = new System.Windows.Forms.Button();
            this.btnReset = new System.Windows.Forms.Button();
            this.btnReadUserMemory = new System.Windows.Forms.Button();
            this.btnResetXR = new System.Windows.Forms.Button();
            this.txtSend = new System.Windows.Forms.TextBox();
            this.btnSend = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // chkReading
            // 
            this.chkReading.AutoSize = true;
            this.chkReading.Location = new System.Drawing.Point(37, 12);
            this.chkReading.Name = "chkReading";
            this.chkReading.Size = new System.Drawing.Size(125, 21);
            this.chkReading.TabIndex = 0;
            this.chkReading.Text = "Reading Active";
            this.chkReading.UseVisualStyleBackColor = true;
            this.chkReading.CheckedChanged += new System.EventHandler(this.chkReading_CheckedChanged);
            // 
            // lblNumReads
            // 
            this.lblNumReads.AutoSize = true;
            this.lblNumReads.Location = new System.Drawing.Point(578, 9);
            this.lblNumReads.Name = "lblNumReads";
            this.lblNumReads.Size = new System.Drawing.Size(16, 17);
            this.lblNumReads.TabIndex = 1;
            this.lblNumReads.Text = "0";
            // 
            // txtReplys
            // 
            this.txtReplys.Font = new System.Drawing.Font("Courier New", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtReplys.Location = new System.Drawing.Point(37, 107);
            this.txtReplys.Multiline = true;
            this.txtReplys.Name = "txtReplys";
            this.txtReplys.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtReplys.Size = new System.Drawing.Size(660, 290);
            this.txtReplys.TabIndex = 2;
            // 
            // btnClear
            // 
            this.btnClear.Location = new System.Drawing.Point(600, 69);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(97, 32);
            this.btnClear.TabIndex = 3;
            this.btnClear.Text = "Clear";
            this.btnClear.UseVisualStyleBackColor = true;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnVersion
            // 
            this.btnVersion.Location = new System.Drawing.Point(37, 69);
            this.btnVersion.Name = "btnVersion";
            this.btnVersion.Size = new System.Drawing.Size(97, 32);
            this.btnVersion.TabIndex = 4;
            this.btnVersion.Text = "Version";
            this.btnVersion.UseVisualStyleBackColor = true;
            this.btnVersion.Click += new System.EventHandler(this.btnVersion_Click);
            // 
            // btnReset
            // 
            this.btnReset.Location = new System.Drawing.Point(140, 69);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(97, 32);
            this.btnReset.TabIndex = 5;
            this.btnReset.Text = "Reset";
            this.btnReset.UseVisualStyleBackColor = true;
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // btnReadUserMemory
            // 
            this.btnReadUserMemory.Location = new System.Drawing.Point(243, 69);
            this.btnReadUserMemory.Name = "btnReadUserMemory";
            this.btnReadUserMemory.Size = new System.Drawing.Size(135, 32);
            this.btnReadUserMemory.TabIndex = 6;
            this.btnReadUserMemory.Text = "Read User Memory";
            this.btnReadUserMemory.UseVisualStyleBackColor = true;
            this.btnReadUserMemory.Click += new System.EventHandler(this.btnReadUserMemory_Click);
            // 
            // btnResetXR
            // 
            this.btnResetXR.Location = new System.Drawing.Point(384, 69);
            this.btnResetXR.Name = "btnResetXR";
            this.btnResetXR.Size = new System.Drawing.Size(135, 32);
            this.btnResetXR.TabIndex = 7;
            this.btnResetXR.Text = "Reset XReads";
            this.btnResetXR.UseVisualStyleBackColor = true;
            this.btnResetXR.Click += new System.EventHandler(this.btnResetXR_Click);
            // 
            // txtSend
            // 
            this.txtSend.Location = new System.Drawing.Point(37, 423);
            this.txtSend.Name = "txtSend";
            this.txtSend.Size = new System.Drawing.Size(557, 22);
            this.txtSend.TabIndex = 9;
            // 
            // btnSend
            // 
            this.btnSend.Location = new System.Drawing.Point(600, 418);
            this.btnSend.Name = "btnSend";
            this.btnSend.Size = new System.Drawing.Size(97, 32);
            this.btnSend.TabIndex = 10;
            this.btnSend.Text = "Send";
            this.btnSend.UseVisualStyleBackColor = true;
            this.btnSend.Click += new System.EventHandler(this.btnSend_Click);
            // 
            // Form1
            // 
            this.AcceptButton = this.btnSend;
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(716, 472);
            this.Controls.Add(this.btnSend);
            this.Controls.Add(this.txtSend);
            this.Controls.Add(this.btnResetXR);
            this.Controls.Add(this.btnReadUserMemory);
            this.Controls.Add(this.btnReset);
            this.Controls.Add(this.btnVersion);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.txtReplys);
            this.Controls.Add(this.lblNumReads);
            this.Controls.Add(this.chkReading);
            this.Name = "Form1";
            this.Text = "TR-200 Desktop RFID Reader";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Form1_FormClosed);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.CheckBox chkReading;
        private System.Windows.Forms.Label lblNumReads;
        private System.Windows.Forms.TextBox txtReplys;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnVersion;
        private System.Windows.Forms.Button btnReset;
        private System.Windows.Forms.Button btnReadUserMemory;
        private System.Windows.Forms.Button btnResetXR;
        private System.Windows.Forms.TextBox txtSend;
        private System.Windows.Forms.Button btnSend;
    }
}

