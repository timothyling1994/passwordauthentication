VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form frmThinkifyReader 
   BackColor       =   &H00FFFFFF&
   Caption         =   "&H8000000F&"
   ClientHeight    =   11850
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14835
   Icon            =   "thinkifyreader_new.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   11850
   ScaleWidth      =   14835
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Interval        =   50
      Left            =   10560
      Top             =   120
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   9840
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   3
      DTREnable       =   -1  'True
      InputLen        =   1
      RThreshold      =   1
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   9975
      Left            =   240
      TabIndex        =   0
      Top             =   720
      Width           =   14295
      _ExtentX        =   25215
      _ExtentY        =   17595
      _Version        =   393216
      Style           =   1
      Tabs            =   6
      TabsPerRow      =   7
      TabHeight       =   882
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Microsoft Sans Serif"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Read Tags"
      TabPicture(0)   =   "thinkifyreader_new.frx":64A2
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "lblCount"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Label4"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "lblCurrentMask"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "cmdClear"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "List1"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "Picture1"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "cmdCopyTagList"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "cmdReading"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).ControlCount=   8
      TabCaption(1)   =   "Read Filtering"
      TabPicture(1)   =   "thinkifyreader_new.frx":64BE
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "frameMasking"
      Tab(1).Control(1)=   "frameRSSI"
      Tab(1).ControlCount=   2
      TabCaption(2)   =   "Programming"
      TabPicture(2)   =   "thinkifyreader_new.frx":64DA
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frame3"
      Tab(2).Control(1)=   "Frame1"
      Tab(2).ControlCount=   2
      TabCaption(3)   =   "Extended Reads"
      TabPicture(3)   =   "thinkifyreader_new.frx":64F6
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Frame2(0)"
      Tab(3).Control(1)=   "Frame2(1)"
      Tab(3).Control(2)=   "Frame2(2)"
      Tab(3).Control(3)=   "Frame2(3)"
      Tab(3).ControlCount=   4
      TabCaption(4)   =   "GPIO"
      TabPicture(4)   =   "thinkifyreader_new.frx":6512
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "Frame5"
      Tab(4).Control(1)=   "Frame6"
      Tab(4).Control(2)=   "Frame7(0)"
      Tab(4).Control(3)=   "Frame7(1)"
      Tab(4).ControlCount=   4
      TabCaption(5)   =   "Command Line Interface"
      TabPicture(5)   =   "thinkifyreader_new.frx":652E
      Tab(5).ControlEnabled=   0   'False
      Tab(5).Control(0)=   "ctlSendReceive1"
      Tab(5).Control(0).Enabled=   0   'False
      Tab(5).Control(1)=   "Frame4"
      Tab(5).Control(1).Enabled=   0   'False
      Tab(5).ControlCount=   2
      Begin VB.Frame Frame7 
         Caption         =   "Triggered Reading (Input 1)"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1695
         Index           =   1
         Left            =   -74520
         TabIndex        =   104
         Top             =   5400
         Width           =   12975
         Begin VB.CheckBox chkTriggeredReadEnabled 
            Alignment       =   1  'Right Justify
            Caption         =   "Enabled"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   1
            Left            =   480
            TabIndex        =   107
            Top             =   600
            Width           =   1695
         End
         Begin VB.ComboBox cmbTrigType 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   480
            Index           =   1
            Left            =   4440
            Style           =   2  'Dropdown List
            TabIndex        =   106
            Top             =   600
            Width           =   2295
         End
         Begin VB.ComboBox cmbOnTime 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   480
            Index           =   1
            Left            =   10440
            Style           =   2  'Dropdown List
            TabIndex        =   105
            Top             =   600
            Width           =   2295
         End
         Begin VB.Label Label5 
            Caption         =   "Trigger Type"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   3
            Left            =   2640
            TabIndex        =   109
            Top             =   600
            Width           =   1935
         End
         Begin VB.Label Label5 
            Caption         =   "On Time (Edge Triggers)"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   2
            Left            =   7080
            TabIndex        =   108
            Top             =   600
            Width           =   3375
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Triggered Reading (Input 0)"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1695
         Index           =   0
         Left            =   -74520
         TabIndex        =   98
         Top             =   3480
         Width           =   12975
         Begin VB.ComboBox cmbOnTime 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   480
            Index           =   0
            Left            =   10440
            Style           =   2  'Dropdown List
            TabIndex        =   103
            Top             =   600
            Width           =   2295
         End
         Begin VB.ComboBox cmbTrigType 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   480
            Index           =   0
            Left            =   4440
            Style           =   2  'Dropdown List
            TabIndex        =   101
            Top             =   600
            Width           =   2295
         End
         Begin VB.CheckBox chkTriggeredReadEnabled 
            Alignment       =   1  'Right Justify
            Caption         =   "Enabled"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   0
            Left            =   480
            TabIndex        =   99
            Top             =   600
            Width           =   1695
         End
         Begin VB.Label Label5 
            Caption         =   "On Time (Edge Triggers)"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   1
            Left            =   7080
            TabIndex        =   102
            Top             =   600
            Width           =   3375
         End
         Begin VB.Label Label5 
            Caption         =   "Trigger Type"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   0
            Left            =   2640
            TabIndex        =   100
            Top             =   600
            Width           =   1935
         End
      End
      Begin VB.Frame Frame6 
         Caption         =   "Digital Outputs"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2535
         Left            =   -67680
         TabIndex        =   95
         Top             =   720
         Width           =   6135
         Begin VB.CheckBox chkOutputs 
            Caption         =   "Output 1"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Index           =   1
            Left            =   3240
            Style           =   1  'Graphical
            TabIndex        =   97
            Top             =   720
            Width           =   2535
         End
         Begin VB.CheckBox chkOutputs 
            Caption         =   "Output 0"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Index           =   0
            Left            =   360
            Style           =   1  'Graphical
            TabIndex        =   96
            Top             =   720
            Width           =   2535
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Digital Inputs"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2535
         Left            =   -74520
         TabIndex        =   92
         Top             =   720
         Width           =   6135
         Begin VB.CommandButton cmdReadInputs 
            Caption         =   "Read Inputs"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   360
            TabIndex        =   110
            Top             =   1560
            Width           =   5415
         End
         Begin VB.CheckBox chkInput1 
            Caption         =   "Input 1"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   3240
            Style           =   1  'Graphical
            TabIndex        =   94
            Top             =   720
            Width           =   2535
         End
         Begin VB.CheckBox chkInput0 
            Caption         =   "Input 0"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   360
            Style           =   1  'Graphical
            TabIndex        =   93
            Top             =   720
            Width           =   2535
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Macro Keys"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   -74640
         TabIndex        =   82
         Top             =   600
         Width           =   12855
         Begin VB.CommandButton cmdHotKeys 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   0
            Left            =   240
            TabIndex        =   90
            ToolTipText     =   "Click to run this macro key. Right-Click to edit."
            Top             =   360
            Width           =   1335
         End
         Begin VB.CommandButton cmdHotKeys 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   1
            Left            =   1800
            TabIndex        =   89
            Top             =   360
            Width           =   1335
         End
         Begin VB.CommandButton cmdHotKeys 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   2
            Left            =   3360
            TabIndex        =   88
            Top             =   360
            Width           =   1335
         End
         Begin VB.CommandButton cmdHotKeys 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   3
            Left            =   4920
            TabIndex        =   87
            Top             =   360
            Width           =   1335
         End
         Begin VB.CommandButton cmdHotKeys 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   4
            Left            =   6480
            TabIndex        =   86
            Top             =   360
            Width           =   1335
         End
         Begin VB.CommandButton cmdHotKeys 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   5
            Left            =   8040
            TabIndex        =   85
            Top             =   360
            Width           =   1335
         End
         Begin VB.CommandButton cmdHotKeys 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   6
            Left            =   9600
            TabIndex        =   84
            Top             =   360
            Width           =   1335
         End
         Begin VB.CommandButton cmdHotKeys 
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   7
            Left            =   11160
            TabIndex        =   83
            Top             =   360
            Width           =   1335
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Read Descriptor 3 (XRead3)"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Index           =   3
         Left            =   -74640
         TabIndex        =   72
         Top             =   7560
         Width           =   13215
         Begin VB.ComboBox cmbReadLength 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   3
            Left            =   10920
            Style           =   2  'Dropdown List
            TabIndex        =   79
            Top             =   960
            Width           =   2055
         End
         Begin VB.ComboBox cmbReadBank 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   3
            Left            =   2280
            Style           =   2  'Dropdown List
            TabIndex        =   78
            Top             =   960
            Width           =   2055
         End
         Begin VB.CheckBox chkXReadActive 
            Alignment       =   1  'Right Justify
            Caption         =   "Active"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   3
            Left            =   240
            TabIndex        =   77
            ToolTipText     =   "Turn on/off Extended Reading"
            Top             =   480
            Width           =   1140
         End
         Begin VB.TextBox txtReadPointer 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   3
            Left            =   6720
            TabIndex        =   76
            Text            =   "00"
            ToolTipText     =   "Pointer into memory (Hex)"
            Top             =   960
            Width           =   2055
         End
         Begin VB.CheckBox chkReadDecimal 
            Alignment       =   1  'Right Justify
            Caption         =   "Treat as Decimal"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   600
            Index           =   3
            Left            =   480
            TabIndex        =   75
            ToolTipText     =   "Format the Xdata as a decimal number"
            Top             =   1440
            Width           =   2535
         End
         Begin VB.OptionButton optByte 
            Caption         =   "Byte Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   3
            Left            =   3480
            TabIndex        =   74
            ToolTipText     =   "Treat each byte separately"
            Top             =   1560
            Value           =   -1  'True
            Width           =   1575
         End
         Begin VB.OptionButton optWordData 
            Caption         =   "Word Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   3
            Left            =   5280
            TabIndex        =   73
            ToolTipText     =   "Combine bytes into words"
            Top             =   1560
            Width           =   1935
         End
         Begin VB.Label lblReadDescriptor 
            Caption         =   "Word Pointer (EBV hex)"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   810
            Index           =   10
            Left            =   4680
            TabIndex        =   113
            Top             =   840
            Width           =   1680
         End
         Begin VB.Label lblReadDescriptor 
            AutoSize        =   -1  'True
            Caption         =   "Memory Bank"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   11
            Left            =   480
            TabIndex        =   81
            Top             =   960
            Width           =   1635
         End
         Begin VB.Label lblReadDescriptor 
            AutoSize        =   -1  'True
            Caption         =   "Words to Read"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   9
            Left            =   9000
            TabIndex        =   80
            Top             =   960
            Width           =   1800
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Read Descriptor 2 (XRead2)"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Index           =   2
         Left            =   -74640
         TabIndex        =   62
         Top             =   5280
         Width           =   13215
         Begin VB.ComboBox cmbReadLength 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   2
            Left            =   10920
            Style           =   2  'Dropdown List
            TabIndex        =   69
            Top             =   960
            Width           =   2055
         End
         Begin VB.ComboBox cmbReadBank 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   2
            Left            =   2280
            Style           =   2  'Dropdown List
            TabIndex        =   68
            Top             =   960
            Width           =   2055
         End
         Begin VB.CheckBox chkXReadActive 
            Alignment       =   1  'Right Justify
            Caption         =   "Active"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   2
            Left            =   240
            TabIndex        =   67
            ToolTipText     =   "Turn on/off Extended Reading"
            Top             =   480
            Width           =   1140
         End
         Begin VB.TextBox txtReadPointer 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   2
            Left            =   6720
            TabIndex        =   66
            Text            =   "00"
            ToolTipText     =   "Pointer into memory (Hex)"
            Top             =   960
            Width           =   2055
         End
         Begin VB.CheckBox chkReadDecimal 
            Alignment       =   1  'Right Justify
            Caption         =   "Treat as Decimal"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   600
            Index           =   2
            Left            =   480
            TabIndex        =   65
            ToolTipText     =   "Format the Xdata as a decimal number"
            Top             =   1440
            Width           =   2535
         End
         Begin VB.OptionButton optByte 
            Caption         =   "Byte Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   2
            Left            =   3480
            TabIndex        =   64
            ToolTipText     =   "Treat each byte separately"
            Top             =   1560
            Value           =   -1  'True
            Width           =   1575
         End
         Begin VB.OptionButton optWordData 
            Caption         =   "Word Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   2
            Left            =   5280
            TabIndex        =   63
            ToolTipText     =   "Combine bytes into words"
            Top             =   1560
            Width           =   1935
         End
         Begin VB.Label lblReadDescriptor 
            Caption         =   "Word Pointer (EBV hex)"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   810
            Index           =   7
            Left            =   4680
            TabIndex        =   112
            Top             =   720
            Width           =   1680
         End
         Begin VB.Label lblReadDescriptor 
            AutoSize        =   -1  'True
            Caption         =   "Memory Bank"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   8
            Left            =   480
            TabIndex        =   71
            Top             =   960
            Width           =   1635
         End
         Begin VB.Label lblReadDescriptor 
            AutoSize        =   -1  'True
            Caption         =   "Words to Read"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   6
            Left            =   9000
            TabIndex        =   70
            Top             =   960
            Width           =   1800
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Read Descriptor 1 (XRead1)"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Index           =   1
         Left            =   -74640
         TabIndex        =   52
         Top             =   3000
         Width           =   13215
         Begin VB.OptionButton optWordData 
            Caption         =   "Word Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   5280
            TabIndex        =   59
            ToolTipText     =   "Combine bytes into words"
            Top             =   1560
            Width           =   1935
         End
         Begin VB.OptionButton optByte 
            Caption         =   "Byte Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   3480
            TabIndex        =   58
            ToolTipText     =   "Treat each byte separately"
            Top             =   1560
            Value           =   -1  'True
            Width           =   1575
         End
         Begin VB.CheckBox chkReadDecimal 
            Alignment       =   1  'Right Justify
            Caption         =   "Treat as Decimal"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   600
            Index           =   1
            Left            =   480
            TabIndex        =   57
            ToolTipText     =   "Format the Xdata as a decimal number"
            Top             =   1440
            Width           =   2535
         End
         Begin VB.TextBox txtReadPointer 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   1
            Left            =   6720
            TabIndex        =   56
            Text            =   "00"
            ToolTipText     =   "Pointer into memory (Hex)"
            Top             =   960
            Width           =   2055
         End
         Begin VB.CheckBox chkXReadActive 
            Alignment       =   1  'Right Justify
            Caption         =   "Active"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   1
            Left            =   240
            TabIndex        =   55
            ToolTipText     =   "Turn on/off Extended Reading"
            Top             =   480
            Width           =   1140
         End
         Begin VB.ComboBox cmbReadBank 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   1
            Left            =   2280
            Style           =   2  'Dropdown List
            TabIndex        =   54
            Top             =   960
            Width           =   2055
         End
         Begin VB.ComboBox cmbReadLength 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   1
            Left            =   10920
            Style           =   2  'Dropdown List
            TabIndex        =   53
            Top             =   960
            Width           =   2055
         End
         Begin VB.Label lblReadDescriptor 
            Caption         =   "Word Pointer (EBV hex)"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   810
            Index           =   4
            Left            =   4680
            TabIndex        =   111
            Top             =   840
            Width           =   1680
         End
         Begin VB.Label lblReadDescriptor 
            AutoSize        =   -1  'True
            Caption         =   "Words to Read"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   5
            Left            =   9000
            TabIndex        =   61
            Top             =   960
            Width           =   1800
         End
         Begin VB.Label lblReadDescriptor 
            AutoSize        =   -1  'True
            Caption         =   "Memory Bank"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   3
            Left            =   480
            TabIndex        =   60
            Top             =   960
            Width           =   1635
         End
      End
      Begin VB.CommandButton cmdReading 
         Caption         =   "Start Reading"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1095
         Left            =   11400
         MaskColor       =   &H8000000F&
         Picture         =   "thinkifyreader_new.frx":654A
         TabIndex        =   2
         ToolTipText     =   "Click to start/stop reading."
         Top             =   1080
         Width           =   2535
      End
      Begin VB.Frame frameRSSI 
         Caption         =   "Signal Level (RSSI) Filter"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1215
         Left            =   -74640
         TabIndex        =   44
         Top             =   720
         Width           =   13095
         Begin VB.CheckBox chkRSSIFilter 
            Alignment       =   1  'Right Justify
            Caption         =   "Active"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   360
            TabIndex        =   46
            ToolTipText     =   "Turn on/off RSSI filtering"
            Top             =   480
            Width           =   1335
         End
         Begin VB.TextBox txtRSSIThreshold 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Left            =   4080
            TabIndex        =   45
            Text            =   "0"
            ToolTipText     =   "Minimum RSSI Value"
            Top             =   480
            Width           =   2055
         End
         Begin VB.Label lblRSSI 
            AutoSize        =   -1  'True
            Caption         =   "Threshold"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   2520
            TabIndex        =   47
            Top             =   480
            Width           =   1290
         End
      End
      Begin VB.Frame frameMasking 
         Caption         =   "EPC Mask"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1455
         Left            =   -74640
         TabIndex        =   35
         Top             =   2040
         Width           =   13095
         Begin VB.CommandButton cmdClearMask 
            Caption         =   "Clear"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   12000
            TabIndex        =   40
            ToolTipText     =   "Clear the Mask (Read all Tags)"
            Top             =   600
            Width           =   975
         End
         Begin VB.CommandButton cmdSetMask 
            Caption         =   "Set"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Left            =   11040
            TabIndex        =   39
            ToolTipText     =   "Set the Mask"
            Top             =   600
            Width           =   975
         End
         Begin VB.TextBox txtMask 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   2
            Left            =   5400
            TabIndex        =   38
            Text            =   "0"
            ToolTipText     =   "Data to Match"
            Top             =   600
            Width           =   5655
         End
         Begin VB.TextBox txtMask 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   1
            Left            =   3480
            TabIndex        =   37
            Text            =   "0"
            ToolTipText     =   "Length in bits (Hex)"
            Top             =   600
            Width           =   735
         End
         Begin VB.TextBox txtMask 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   0
            Left            =   1440
            TabIndex        =   36
            Text            =   "0"
            ToolTipText     =   "Pointer into EPC Memory"
            Top             =   600
            Width           =   735
         End
         Begin VB.Label lblMaskLabels 
            Caption         =   "Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   2
            Left            =   4560
            TabIndex        =   43
            Top             =   600
            Width           =   1455
         End
         Begin VB.Label lblMaskLabels 
            Caption         =   "Length"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   1
            Left            =   2400
            TabIndex        =   42
            Top             =   600
            Width           =   1455
         End
         Begin VB.Label lblMaskLabels 
            Caption         =   "Pointer"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   0
            Left            =   360
            TabIndex        =   41
            Top             =   600
            Width           =   1455
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "EPC Programming (Bank 1)"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2055
         Left            =   -74640
         TabIndex        =   28
         Top             =   720
         Width           =   13215
         Begin VB.CommandButton cmdProgramEPC 
            Caption         =   "Program EPC"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   8160
            TabIndex        =   31
            Top             =   480
            Width           =   2055
         End
         Begin VB.CheckBox chkAutoIncrementEPC 
            Alignment       =   1  'Right Justify
            Caption         =   "Auto Increment"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   10440
            TabIndex        =   30
            ToolTipText     =   "Increment the EPC on a successful program"
            Top             =   600
            Width           =   2295
         End
         Begin VB.TextBox txtEPCTarget 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Left            =   3120
            TabIndex        =   29
            Text            =   "1111 2222 3333 4444 5555 6666"
            Top             =   600
            Width           =   4695
         End
         Begin VB.PictureBox pictProgResult 
            Height          =   615
            Left            =   3000
            ScaleHeight     =   555
            ScaleWidth      =   4875
            TabIndex        =   32
            Top             =   480
            Width           =   4935
         End
         Begin VB.Label lblProgramming 
            Caption         =   "EPC To Program"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   615
            Index           =   0
            Left            =   360
            TabIndex        =   34
            Top             =   600
            Width           =   2415
         End
         Begin VB.Label lblProgramming 
            Caption         =   "Result:"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   1
            Left            =   360
            TabIndex        =   33
            Top             =   1320
            Width           =   7455
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "User Memory Programming (Bank 3)"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2775
         Left            =   -74640
         TabIndex        =   20
         Top             =   2880
         Width           =   13215
         Begin VB.CheckBox chkAutoIncrementUser 
            Alignment       =   1  'Right Justify
            Caption         =   "Auto Increment"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Left            =   10440
            TabIndex        =   48
            ToolTipText     =   "Increment the User memory on a successful program"
            Top             =   1440
            Width           =   2295
         End
         Begin VB.TextBox txtUserTarget 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Left            =   3120
            TabIndex        =   23
            Text            =   "0000"
            Top             =   1440
            Width           =   4695
         End
         Begin VB.CommandButton cmdProgramUserMemory 
            Caption         =   "Program User Memory"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   8160
            TabIndex        =   22
            Top             =   1320
            Width           =   2055
         End
         Begin VB.TextBox txtUserPointer 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Left            =   3000
            TabIndex        =   21
            Text            =   "00"
            ToolTipText     =   "Pointer into User memory for the write. (Hex)"
            Top             =   600
            Width           =   735
         End
         Begin VB.PictureBox pictProgResultUser 
            Height          =   615
            Left            =   3000
            ScaleHeight     =   555
            ScaleWidth      =   4875
            TabIndex        =   24
            Top             =   1320
            Width           =   4935
         End
         Begin VB.Label lblProgramming 
            Caption         =   "Result:"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   495
            Index           =   2
            Left            =   360
            TabIndex        =   27
            Top             =   2040
            Width           =   7455
         End
         Begin VB.Label lblProgramming 
            Caption         =   "Data (hex)"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   615
            Index           =   3
            Left            =   360
            TabIndex        =   26
            Top             =   1320
            Width           =   2415
         End
         Begin VB.Label lblProgramming 
            Caption         =   "Pointer (hex)"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   615
            Index           =   4
            Left            =   360
            TabIndex        =   25
            Top             =   600
            Width           =   2415
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Read Descriptor 0 (XRead0)"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Index           =   0
         Left            =   -74640
         TabIndex        =   11
         Top             =   720
         Width           =   13215
         Begin VB.ComboBox cmbReadLength 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   0
            Left            =   10920
            Style           =   2  'Dropdown List
            TabIndex        =   51
            Top             =   960
            Width           =   2055
         End
         Begin VB.ComboBox cmbReadBank 
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   0
            Left            =   2280
            Style           =   2  'Dropdown List
            TabIndex        =   50
            Top             =   960
            Width           =   2055
         End
         Begin VB.CheckBox chkXReadActive 
            Alignment       =   1  'Right Justify
            Caption         =   "Active"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   0
            Left            =   240
            TabIndex        =   16
            ToolTipText     =   "Turn on/off Extended Reading"
            Top             =   480
            Width           =   1140
         End
         Begin VB.TextBox txtReadPointer 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   420
            Index           =   0
            Left            =   6720
            TabIndex        =   15
            Text            =   "00"
            ToolTipText     =   "Pointer into memory (Hex)"
            Top             =   960
            Width           =   2055
         End
         Begin VB.CheckBox chkReadDecimal 
            Alignment       =   1  'Right Justify
            Caption         =   "Treat as Decimal"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   600
            Index           =   0
            Left            =   480
            TabIndex        =   14
            ToolTipText     =   "Format the Xdata as a decimal number"
            Top             =   1440
            Width           =   2535
         End
         Begin VB.OptionButton optByte 
            Caption         =   "Byte Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   3480
            TabIndex        =   13
            ToolTipText     =   "Treat each byte separately"
            Top             =   1560
            Value           =   -1  'True
            Width           =   1575
         End
         Begin VB.OptionButton optWordData 
            Caption         =   "Word Data"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   5280
            TabIndex        =   12
            ToolTipText     =   "Combine bytes into words"
            Top             =   1560
            Width           =   1935
         End
         Begin VB.Label lblReadDescriptor 
            AutoSize        =   -1  'True
            Caption         =   "Memory Bank"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   0
            Left            =   480
            TabIndex        =   19
            Top             =   960
            Width           =   1635
         End
         Begin VB.Label lblReadDescriptor 
            Caption         =   "Word Pointer (EBV hex)"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   810
            Index           =   1
            Left            =   4680
            TabIndex        =   18
            Top             =   840
            Width           =   1680
         End
         Begin VB.Label lblReadDescriptor 
            AutoSize        =   -1  'True
            Caption         =   "Words to Read"
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   2
            Left            =   9000
            TabIndex        =   17
            Top             =   960
            Width           =   1800
         End
      End
      Begin VB.CommandButton cmdCopyTagList 
         Caption         =   "Copy to Clipboard"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   15.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   8040
         TabIndex        =   10
         ToolTipText     =   "Copies the List to the Clipboard."
         Top             =   8040
         Width           =   3015
      End
      Begin VB.PictureBox Picture1 
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   3000
         Left            =   11880
         Picture         =   "thinkifyreader_new.frx":14164
         ScaleHeight     =   200
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   82
         TabIndex        =   6
         Top             =   6720
         Width           =   1230
      End
      Begin VB.ListBox List1 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   18
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   6945
         Left            =   240
         MultiSelect     =   2  'Extended
         TabIndex        =   4
         ToolTipText     =   "Double Click on a tag to Mask just that one tag."
         Top             =   1080
         Width           =   10815
      End
      Begin VB.CommandButton cmdClear 
         Caption         =   "Clear List"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   15.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   5040
         TabIndex        =   1
         ToolTipText     =   "Deletes all Tags in the List."
         Top             =   8040
         Width           =   3015
      End
      Begin Thinkify.ctlSendReceive ctlSendReceive1 
         Height          =   7935
         Left            =   -74640
         TabIndex        =   91
         ToolTipText     =   "Type commands to the reader"
         Top             =   1680
         Width           =   12855
         _ExtentX        =   22675
         _ExtentY        =   13996
      End
      Begin VB.Label lblCurrentMask 
         Caption         =   "Current Mask: ALL TAGS"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1695
         Left            =   240
         TabIndex        =   49
         Top             =   8040
         Width           =   7335
      End
      Begin VB.Label Label4 
         Caption         =   "EPC / XRead                Count     Signal Level"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   240
         TabIndex        =   9
         Top             =   720
         Width           =   11055
      End
      Begin VB.Label lblCount 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Tags: 0"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   36
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   825
         Left            =   11400
         TabIndex        =   3
         Top             =   2280
         Width           =   2535
      End
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "...by Thinkify "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   585
      Left            =   11160
      TabIndex        =   8
      Top             =   10920
      Width           =   2925
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "TR-200 "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   585
      Left            =   1080
      TabIndex        =   7
      Top             =   0
      Width           =   1680
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "The            RFID Reader "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   585
      Left            =   240
      TabIndex        =   5
      Top             =   0
      Width           =   5490
   End
End
Attribute VB_Name = "frmThinkifyReader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'Thinkify Reader Demonstration Program
'Copyright 2011, Thinkify, LLC. All rights reserved.

'Data structure for HotKey information
Private Type HotKeyData
     Caption As String
     Command As String
End Type

Dim HotKeys(7) As HotKeyData

Dim WithEvents reader As clsThinkifyReader
Attribute reader.VB_VarHelpID = -1


Private Sub chkOutputs_Click(Index As Integer)
' Set the GPO lines

   If chkOutputs(Index).value = vbChecked Then
      reader.sendReceive ("G" & Trim(str(Index)) & "0")
      chkOutputs(Index).Caption = "Output " & Index & "= 0"
   Else
      reader.sendReceive ("G" & Trim(str(Index)) & "1")
      chkOutputs(Index).Caption = "Output " & Index & "= 1"
   End If
      
End Sub

Private Sub chkTriggeredReadEnabled_Click(Index As Integer)
    Dim strCommand As String
    
    'Set up for Triggered reading...
    If chkTriggeredReadEnabled(Index).value = vbChecked Then
    
        strCommand = "GT" & Trim(str(Index)) & "1" & cmbTrigType(Index).ListIndex & "3"
        If cmbTrigType(Index).ListIndex < 2 Then 'edge triggers need a time...
            strCommand = strCommand & Format(Hex(cmbOnTime(Index).ListIndex), "00")
        End If
        
        reader.sendReceive (strCommand)
        
        'Disable the Reading in the interface.
        cmdReading.Caption = "Triggered Reading"
        cmdReading.Enabled = False
        
    Else
        strCommand = "GT" & Trim(str(Index)) & "0"
        reader.sendReceive (strCommand)
        
        cmdReading.Caption = "Start Reading"
        cmdReading.Enabled = True
        
        
    End If
End Sub


'**********************************************************************************
'Hotkeys
'**********************************************************************************
Private Sub cmdHotKeys_Click(Index As Integer)
    Dim commands
    Dim i As Integer
    
    commands = Split(HotKeys(Index).Command, vbCrLf)

    For i = 0 To UBound(commands)
        If commands(i) <> "" Then
            ctlSendReceive1_SendString (commands(i))
        End If
    Next i

End Sub

Private Sub cmdHotKeys_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    If Button = 2 Then
        frmHotKey.SetData Index, HotKeys(Index).Caption, HotKeys(Index).Command
        frmHotKey.Show 1
    End If

End Sub

Public Function SetHotKey(Index As Integer, Caption As String, Command As String)
    HotKeys(Index).Caption = Caption
    HotKeys(Index).Command = Command
    cmdHotKeys(Index).Caption = Caption
End Function

'**********************************************************************************
'Pad a string with spaces.
'**********************************************************************************
Private Function PadField(max As Integer, strField As String)
    Dim retval As String
            
    If max - Len(strField) > 0 Then
      retval = Space(max - Len(strField))
    Else
      retval = " "
    End If
    
    PadField = retval
    
End Function

'**********************************************************************************
''takes a space-padded string and removes extra spaces, replacing with tabs
'**********************************************************************************
Private Function StripSpaces(paddedString As String) As String

    Dim data
    Dim strResult As String
    Dim i As Integer
    
    data = Split(paddedString, " ")
    
    For i = 0 To UBound(data)
        If data(i) <> "" Then
            strResult = strResult & data(i) & vbTab
        End If
    Next i
    
    StripSpaces = strResult
    
End Function

'**********************************************************************************
'Run a script.
'**********************************************************************************
Private Sub RunFile(fn As String)
'Load a file and run it...
    Dim f As New FileSystemObject
    Dim t As TextStream
    Dim strCommand As String
    
    On Error GoTo RunFileErr

    Set t = f.OpenTextFile(fn, ForReading, True)
    
    While Not t.AtEndOfStream

        strCommand = t.ReadLine
        If Mid(strCommand, 1, 1) = "!" Then
            ParseCommand (strCommand)
        ElseIf Mid(strCommand, 1, 1) = "#" Then
            'Line is a comment
        Else
             ctlSendReceive1_SendString (strCommand)
        End If
      
    Wend
    
    t.Close
    Exit Sub

RunFileErr:
    MsgBox "Error: Problem loading file.", vbExclamation
   
End Sub

'**********************************************************************************
'Parse Script commands.
'**********************************************************************************
Private Sub ParseCommand(strCommand As String)
    Dim TEMP
    Dim i As Integer
    
    TEMP = Split(strCommand, "=")
    
    For i = 0 To UBound(TEMP)
        TEMP(i) = LCase(Trim(TEMP(i)))
    Next i
    
    Select Case TEMP(0)
    Case "!comment"
    Case "!load"
    Case "!clear"
    Case "!timedread"

    Case "!delay"
      Dim myTimer As New clsTimer
      myTimer.TimeOutValue = TEMP(1)
      myTimer.Start
      While myTimer.TimedOut = False
        DoEvents
      Wend

    Case "!run"
        
      RunFile (TEMP(1))
    
    Case Else
    
    End Select
    

End Sub

'**********************************************************************************
'Tag List UI
'**********************************************************************************
Private Sub ProcessTagList()
    Dim i As Integer
    Dim totalCount As Long
    
    Dim bAddTag As Boolean
    Dim strItem As String
            
    List1.Clear

    For i = 1 To UBound(TagList)
    
        bAddTag = False
        
        If chkRSSIFilter.value = vbChecked Then
          If TagList(i).rssi > txtRSSIThreshold Then
            bAddTag = True
          End If
        Else
           bAddTag = True
        End If
        
        If bAddTag Then
            strItem = ""
            
            Dim xrdata(3) As String
            Dim j As Integer
            Dim k As Integer
            
            For k = 0 To 3
                xrdata(k) = ""
                If chkReadDecimal(k).value = vbChecked Then
                
                    If Len(TagList(i).xrdata(k)) > 0 Then
                        If optByte(k) Then
                            For j = 1 To Len(TagList(i).xrdata(k)) Step 2
                                xrdata(k) = xrdata(k) & str(Int("&H" & Mid(TagList(i).xrdata(k), j, 2))) & " "
                            Next j
                        Else
                            For j = 1 To Len(TagList(i).xrdata(k)) Step 4
                                xrdata(k) = xrdata(k) & str(Int("&H" & Mid(TagList(i).xrdata(k), j, 4))) & " "
                            Next j
                        End If
                        
                    End If
                    
                Else
                   
                    xrdata(k) = TagList(i).xrdata(k)
                    
                End If
                
            Next k
                     
            strItem = strItem & TagList(i).epc & PadField(28, TagList(i).epc) & _
                       TagList(i).count & PadField(13, str(TagList(i).count)) & _
                       Format(TagList(i).rssi, "0.00")
                       
            List1.AddItem strItem
            
            For k = 0 To 3
                If chkXReadActive(k).value = vbChecked Then
                    strItem = "   XREAD" & Trim(str(k)) & " " & xrdata(k) '& PadField(20, xrdata(k))
                    List1.AddItem strItem
                End If
            Next k
            
            
        End If
        
        totalCount = totalCount + TagList(i).count
        
    Next i
    
    Dim strCountCaption As String
    strCountCaption = "Tags" & vbCrLf & UBound(TagList) & vbCrLf & "Count" & vbCrLf & totalCount
    lblCount.Caption = strCountCaption
  
End Sub

Public Sub ClearTagList()
    ReDim TagList(0) As tagListElement
    List1.Clear
    lblCount.Caption = "Tags" & vbCrLf & "0" & vbCrLf & "Count" & vbCrLf & "0"
End Sub

Private Sub cmdClear_Click()
    ClearTagList
End Sub

Private Sub cmdClearMask_Click()

   txtMask(0).text = 0
   txtMask(1).text = 0
   txtMask(2).text = -1
   reader.setEPCMask txtMask(0), txtMask(1), txtMask(2)
   lblCurrentMask.Caption = "Current Mask:" & vbCrLf & "ALL TAGS"
   lblCurrentMask.ForeColor = vbBlack
   
End Sub

Private Sub cmdCopyTagList_Click()
    CopyTagListSelection (True)
End Sub

'**********************************************************************************
'Bump an EPC (Hex string) by one
'**********************************************************************************
Private Function IncrementEPC(strEPC As String, position As Integer) As String
'Let's do it recursively...
    Dim intValue As Integer
    Dim strResult As String
    Dim thisChar As String
    
    strResult = strEPC
    
    If (position > 0) And (position <= Len(strEPC)) Then
        
        thisChar = Mid(strEPC, position, 1)
        intValue = Int("&H" & thisChar)
        
        If intValue + 1 > 15 Then
            Mid(strEPC, position, 1) = "0"
            position = position - 1
            strResult = IncrementEPC(strEPC, position)
        Else
            Mid(strEPC, position, 1) = Format(Hex(intValue + 1), "0")
            strResult = strEPC
        End If
        
    End If
    
    IncrementEPC = strResult
    
End Function

'**********************************************************************************
'Program an EPC into a tag. -- NB: Current mask is used!
'**********************************************************************************
Private Sub cmdProgramEPC_Click()

    Dim progResult As Boolean
    
    txtEPCTarget.text = Replace(txtEPCTarget.text, " ", "")
    
    If Len(txtEPCTarget.text) Mod 4 <> 0 Then
        MsgBox ("EPC to Program must be Word-Aligned. -- Multiples of 4 Characters.")
        Exit Sub
    End If
    
    pictProgResult.BackColor = &H8000000F
    lblProgramming(1).Caption = "Result: Working..."
    
    progResult = reader.program_epc(txtEPCTarget.text)
    
    If progResult = True Then
        pictProgResult.BackColor = vbGreen
        lblProgramming(1).Caption = "Result: Success!"
        If chkAutoIncrementEPC.value = vbChecked Then
            txtEPCTarget.text = IncrementEPC(txtEPCTarget.text, Len(txtEPCTarget.text))
        End If
    Else
        pictProgResult.BackColor = vbRed
        lblProgramming(1).Caption = "Result: Programming Failed."
    End If
    
End Sub

'**********************************************************************************
'Program an User Memory into a tag. -- NB: Current mask is used!
'**********************************************************************************
Private Sub cmdProgramUserMemory_Click()

    Dim progResult As Boolean
    
    txtUserTarget.text = Replace(txtUserTarget.text, " ", "")
    
    If Len(txtUserTarget.text) Mod 4 <> 0 Then
        MsgBox ("User Data to Program must be Word-Aligned. -- Multiples of 4 Characters.")
        Exit Sub
    End If
    
    pictProgResult.BackColor = &H8000000F
    lblProgramming(2).Caption = "Result: Working..."
    
    progResult = reader.program_user(txtUserPointer.text, txtUserTarget.text)
    
    If progResult = True Then
        pictProgResultUser.BackColor = vbGreen
        lblProgramming(2).Caption = "Result: Success!"
        If chkAutoIncrementUser.value = vbChecked Then
            txtUserTarget.text = IncrementEPC(txtUserTarget.text, Len(txtUserTarget.text))
        End If
    Else
        pictProgResultUser.BackColor = vbRed
        lblProgramming(2).Caption = "Result: Programming Failed."
    End If
    
End Sub

'**********************************************************************************
'Show the Digital Input State
'**********************************************************************************
Private Sub cmdReadInputs_Click()
    Dim strreply As String
       
    strreply = reader.sendReceive("G")
    
    If InStr(strreply, "GPINPUT0=1") Then
        chkInput0.Caption = "Input 0 = 1"
        chkInput0.value = vbUnchecked
    Else
        chkInput0.Caption = "Input 0 = 0"
        chkInput0.value = vbChecked
    End If
     
    If InStr(strreply, "GPINPUT1=1") Then
        chkInput1.Caption = "Input 1 = 1"
        chkInput1.value = vbUnchecked
    Else
        chkInput1.Caption = "Input 1 = 0"
        chkInput1.value = vbChecked
    End If
   
End Sub

Private Sub cmdSetMask_Click()
    reader.setEPCMask txtMask(0).text, txtMask(1).text, txtMask(2).text
    Dim currentMask As String
    
    currentMask = "Pointer = " & txtMask(0).text & vbCrLf & "Length = " & txtMask(1).text & vbCrLf & "Data = " & txtMask(2).text
    MsgBox ("Read mask set to: " & vbCrLf & currentMask)
    lblCurrentMask.Caption = "Current Mask: " & vbCrLf & currentMask
    lblCurrentMask.ForeColor = vbRed
    
End Sub

Private Sub SetMaskFrame(value As Boolean)

    frameMasking.Enabled = value
    
    lblMaskLabels(0).Enabled = value
    lblMaskLabels(1).Enabled = value
    lblMaskLabels(2).Enabled = value
    
    txtMask(0).Enabled = value
    txtMask(1).Enabled = value
    txtMask(2).Enabled = value
    cmdSetMask.Enabled = value
    
    cmdClearMask.Enabled = value

End Sub

'**********************************************************************************
'Toggle reading.
'**********************************************************************************
Private Sub SetReading(bReading As Boolean)
  
  reader.reading = bReading
  
  If bReading Then
    SetMaskFrame (False)
    If cmdReading.Caption <> "Triggered Reading" Then
        cmdReading.Caption = "Stop Reading"
    End If
  Else
    SetMaskFrame (True)
    If cmdReading.Caption <> "Triggered Reading" Then
        cmdReading.Caption = "Start Reading"
    End If
  End If
  
End Sub

Private Sub cmdReading_Click()
  SetReading (Not reader.reading)
End Sub


'**********************************************************************************
'Set the XDATA descriptors for extended reading of memory as part of the taglist.
'**********************************************************************************
Private Sub SetReadDescriptors()
    Dim i As Integer
    
    For i = 0 To 3
        txtReadPointer(i).text = Trim(txtReadPointer(i).text)
        
        If Len(txtReadPointer(i).text) < 2 Then
            txtReadPointer(i).text = "0" & txtReadPointer(i).text
        End If
        
        If chkXReadActive(i).value = vbChecked Then
            reader.sendReceive ("XR" & Trim(str(i)) & "1" & Trim(str(cmbReadBank(i).ListIndex)) & Trim(cmbReadLength(i).text) & Trim(txtReadPointer(i).text))
        Else
            reader.sendReceive ("XR" & Trim(str(i)) & "0")
        End If
    Next i
    
End Sub


'**********************************************************************************
'Command Line Interface Event
'**********************************************************************************
Private Sub ctlSendReceive1_SendString(s As String)

  s = LCase(s)
  'Macro command. -- Parse it.
  If Mid(s, 1, 1) = "!" Then
    ParseCommand (s)
  Else
    'Tn commands are asynchronous.
    If (s = "t6") Or (s = "t5") Or (s = "t4") Or (s = "t3") Then
        reader.send (s)
    Else
        'synchronous command.
        reader.sendReceive (s)
    End If
  End If
  
End Sub

'**********************************************************************************
'Save program state.
'**********************************************************************************
Private Sub SaveDefaults()
    Dim i As Integer
    Dim fn As String
    Dim strTemp As String
    
    fn = App.Path & "\" & "defaults.ini"
    
    For i = 0 To UBound(HotKeys)
        WritePrivateProfileString "HKCaption", CStr(i), HotKeys(i).Caption, fn
        strTemp = Replace(HotKeys(i).Command, vbCrLf, "<vbcrlf>")
        WritePrivateProfileString "HKCommand", CStr(i), strTemp, fn
    Next i
    
End Sub

'**********************************************************************************
'Load control values / macros.
'**********************************************************************************
Private Sub LoadDefaults()
    Dim i As Integer
    Dim k As Integer
    Dim fn As String
      
    fn = App.Path & "\" & "defaults.ini"
    
    For i = 0 To UBound(HotKeys)
        HotKeys(i).Caption = GetFromIni(fn, "HKCaption", CStr(i))
        HotKeys(i).Command = GetFromIni(fn, "HKCommand", CStr(i))
        cmdHotKeys(i).Caption = HotKeys(i).Caption
    Next i
       
    For k = 0 To 3
    
        cmbReadBank(k).AddItem "Reserved"
        cmbReadBank(k).AddItem "EPC"
        cmbReadBank(k).AddItem "TID"
        cmbReadBank(k).AddItem "USER"
        
        cmbReadBank(k).ListIndex = 0
        
        For i = 1 To 8
            cmbReadLength(k).AddItem str(i)
        Next i
        
        cmbReadLength(k).ListIndex = 0
    Next k
  
  
    For k = 0 To 1
        cmbTrigType(k).AddItem "Pos Edge"
        cmbTrigType(k).AddItem "Neg Edge"
        cmbTrigType(k).AddItem "Pos Level"
        cmbTrigType(k).AddItem "Neg Level"
        
        cmbTrigType(k).ListIndex = 2
        
        For i = 0 To 255
          cmbOnTime(k).AddItem str(CSng(i) / 10) & " sec"
        Next i
        
        cmbOnTime(k).ListIndex = 10
    
    Next k
    
    
    
    
End Sub

'**********************************************************************************
'
'**********************************************************************************
Private Sub Form_Load()
    Dim connected As Boolean
    
    frmSplash.Show 1
    Me.Caption = App.ProductName & "  Version " & App.Major & "." & App.Minor & "." & App.Revision
    
    LoadDefaults

    'create a new reader
    Set reader = New clsThinkifyReader
    
    'point the reader to a com port control and a timer
    reader.setControls MSComm1, Timer1
    
    'reader.connect scans the com ports for a reader and connects to the first one it finds.
    connected = reader.Connect
    
    If connected = False Then
        MsgBox "No Thinkify reader found! Please check connections and restart. Click OK to exit.", vbCritical
        Unload Me
    End If
    
    ReDim TagList(0) As tagListElement
    
    'set up some inventory parameters...
    reader.sendReceive ("")
    reader.sendReceive ("iq6")
    reader.sendReceive ("ii4")
    reader.sendReceive ("iw2")
    reader.sendReceive ("is2")

    'clear the masks -- read all tags.
    cmdClearMask_Click
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    SaveDefaults
    End
End Sub

Private Sub CopyTagListSelection(Optional all = False)
    Dim strData As String
    Dim i As Integer

    Clipboard.Clear
    
    For i = 0 To List1.ListCount - 1
        If all Then
            strData = strData & StripSpaces(List1.List(i)) & vbCrLf
        ElseIf List1.Selected(i) Then
            strData = strData & StripSpaces(List1.List(i)) & vbCrLf
        End If
    Next i
    
    Clipboard.SetText strData
End Sub

Private Sub List1_KeyPress(KeyAscii As Integer)
    If KeyAscii = 3 Then 'ctl-c
        CopyTagListSelection
    End If
End Sub

Private Sub List1_DblClick()

  Dim i As Integer
  Dim strID
  
  strID = Split(List1.List(List1.ListIndex), " ")
  
  If UBound(strID) > 0 Then
    txtMask(0).text = "20"
    txtMask(1).text = Format(Hex(Len(strID(0)) * 4), "00")
    txtMask(2).text = strID(0)
  End If
   
  cmdSetMask_Click

End Sub

'READER Events -- Catch these to do interesting things from your application.
Private Sub reader_DataReceived(message As String)
    ctlSendReceive1.AppendText message
End Sub

'This event is called when we see a new tag.
Private Sub reader_tagAdded(tagid As String, TagListIndex As Integer)
    ProcessTagList
End Sub

'This event is called when a tag on the taglist is seen again.
Private Sub reader_tagUpdated(tagid As String, count As Long, TagListIndex As Integer)
    ProcessTagList
End Sub

Private Sub SSTab1_Click(PreviousTab As Integer)

    If PreviousTab = 0 Then
        SetReading (False)
    End If
    
    If PreviousTab = 3 Then
        SetReadDescriptors
    End If
     
    
End Sub

