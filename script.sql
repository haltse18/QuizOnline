USE [master]
GO
/****** Object:  Database [DB_QuizOnline]    Script Date: 10-Mar-21 2:54:56 PM ******/
CREATE DATABASE [DB_QuizOnline]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_QuizOnline', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DB_QuizOnline.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB_QuizOnline_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DB_QuizOnline_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DB_QuizOnline] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_QuizOnline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_QuizOnline] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_QuizOnline] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_QuizOnline] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_QuizOnline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_QuizOnline] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DB_QuizOnline] SET  MULTI_USER 
GO
ALTER DATABASE [DB_QuizOnline] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_QuizOnline] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_QuizOnline] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_QuizOnline] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DB_QuizOnline] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DB_QuizOnline]
GO
/****** Object:  Table [dbo].[tbl_Answer]    Script Date: 10-Mar-21 2:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Answer](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[questionID] [int] NULL,
	[answer_content] [nvarchar](100) NULL,
	[correct] [bit] NULL,
 CONSTRAINT [PK_tbl_Answer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Details]    Script Date: 10-Mar-21 2:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Details](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[quizID] [bigint] NULL,
	[questionID] [bigint] NULL,
	[answerID] [bigint] NULL,
 CONSTRAINT [PK_tbl_Details] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Question]    Script Date: 10-Mar-21 2:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Question](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[question_content] [nvarchar](500) NULL,
	[subjectID] [nvarchar](10) NULL,
	[createDate] [datetime] NULL,
	[status] [nvarchar](10) NULL,
 CONSTRAINT [PK_tbl_Question] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Quiz]    Script Date: 10-Mar-21 2:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Quiz](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[userID] [nvarchar](50) NULL,
	[subjectID] [nvarchar](10) NULL,
	[mark] [float] NULL,
	[time] [datetime] NULL,
 CONSTRAINT [PK_tbl_Quiz] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Subject]    Script Date: 10-Mar-21 2:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Subject](
	[id] [nvarchar](10) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Subject] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Users]    Script Date: 10-Mar-21 2:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Users](
	[id] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[password] [binary](50) NULL,
	[role] [nvarchar](10) NULL,
	[status] [nvarchar](10) NULL,
 CONSTRAINT [PK_tbl_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Answer] ON 

INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (1, 1, N'lightweight components', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (2, 1, N'heavyweight components', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (3, 1, N'GUI components', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (4, 1, N'non-GUI components', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (5, 2, N'AWT components', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (6, 2, N'Swing components', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (7, 2, N'GUI components', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (8, 2, N'Non-GUI components', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (9, 3, N'JButton', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (10, 3, N'JTextField', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (11, 3, N'JPanel', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (12, 3, N'JFrame', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (13, 4, N'JPanel', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (14, 4, N'JButton', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (15, 4, N'JFrame', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (16, 4, N'JComponent', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (17, 5, N'Association', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (18, 5, N'Aggregation', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (19, 5, N'Composition', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (20, 5, N'Inheritance', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (21, 6, N'Association', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (22, 6, N'Aggregation', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (23, 6, N'Composition', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (24, 6, N'Inheritance', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (25, 7, N'frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (26, 7, N'frame.setDefaultCloseOperation(null)', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (27, 7, N'rame.setDefaultCloseOperation(JFrame.STOP_ON_CLOSE)', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (28, 7, N'frame.setDefaultCloseOperation(JFrame.TERMINATE_ON_CLOSE)', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (29, 8, N'a FlowLayout', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (30, 8, N'a GridLayout', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (31, 8, N'a BorderLayout', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (32, 8, N'any layout', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (33, 9, N'1', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (34, 9, N'2', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (35, 9, N'3', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (36, 9, N'4', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (37, 10, N'FlowLayout', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (38, 10, N'GridLayout', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (39, 10, N'BorderLayout', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (40, 10, N'None', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (41, 11, N'JPanel p = new JPanel();', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (42, 11, N'JPanel p = new JPanel(BorderLayout());', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (43, 11, N'JPanel p = new JPanel(new BorderLayout());', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (44, 11, N'JPanel p = new JPanel().setLayout(new BorderLayout());  A', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (45, 12, N'p.add(c)', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (46, 12, N'p.getContentPane(c)', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (47, 12, N'p.insert(c)', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (48, 12, N'p.append(c)', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (49, 13, N'c.setFont(new Font("Helvetica", Font.bold, 20))', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (50, 13, N'c.setFont(new Font("helvetica", BOLD, 20))', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (51, 13, N'c.setFont(Font("Helvetica", Font.BOLD, 20))', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (52, 13, N'c.setFont(new Font("Helvetica", Font.BOLD, 20))', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (53, 14, N'Font.PLAIN', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (54, 14, N'Font.BOLD', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (55, 14, N'Font.ITALIC', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (56, 14, N'Font.BOLD + Font.ITALIC', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (57, 15, N'Scriptlets', 1)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (58, 15, N'expressions', 0)
INSERT [dbo].[tbl_Answer] ([id], [questionID], [answer_content], [correct]) VALUES (59, 15, N'declarations', 0)
SET IDENTITY_INSERT [dbo].[tbl_Answer] OFF
SET IDENTITY_INSERT [dbo].[tbl_Details] ON 

INSERT [dbo].[tbl_Details] ([id], [quizID], [questionID], [answerID]) VALUES (1, 1, 8, 30)
INSERT [dbo].[tbl_Details] ([id], [quizID], [questionID], [answerID]) VALUES (2, 1, 13, 49)
INSERT [dbo].[tbl_Details] ([id], [quizID], [questionID], [answerID]) VALUES (3, 1, 14, 56)
INSERT [dbo].[tbl_Details] ([id], [quizID], [questionID], [answerID]) VALUES (4, 1, 15, 57)
INSERT [dbo].[tbl_Details] ([id], [quizID], [questionID], [answerID]) VALUES (5, 2, 2, 5)
INSERT [dbo].[tbl_Details] ([id], [quizID], [questionID], [answerID]) VALUES (6, 2, 6, 24)
INSERT [dbo].[tbl_Details] ([id], [quizID], [questionID], [answerID]) VALUES (7, 2, 7, 27)
INSERT [dbo].[tbl_Details] ([id], [quizID], [questionID], [answerID]) VALUES (8, 2, 12, 45)
SET IDENTITY_INSERT [dbo].[tbl_Details] OFF
SET IDENTITY_INSERT [dbo].[tbl_Question] ON 

INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (1, N'Swing components that don''t rely on native GUI are referred to as ___________.', N'PRJ311', CAST(N'2021-03-01 22:57:10.523' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (2, N'__________ are referred to as heavyweight components.', N'PRJ311', CAST(N'2021-03-04 14:27:29.357' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (3, N'Which of the following classes is a heavyweight component?', N'PRJ311', CAST(N'2021-03-04 14:28:34.180' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (4, N'Which component cannot be added to a container?', N'PRJ311', CAST(N'2021-03-04 14:29:19.767' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (5, N'What is best to describe the relationship between a container and a SWing GUI object in the container?', N'PRJ311', CAST(N'2021-03-04 14:30:12.933' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (6, N'What is best to describe the relationship between a container and a layout manager?', N'PRJ311', CAST(N'2021-03-04 14:30:59.137' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (7, N'Which of the following statements is for terminating the program when closing the frame?', N'PRJ311', CAST(N'2021-03-04 14:34:31.333' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (8, N'What layout manager should you use so that every component occupies the same size in the container?', N'PRJ311', CAST(N'2021-03-04 14:40:40.687' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (9, N'Suppose a JFrame uses the GridLayout(2, 2). If you add six buttons to the frame, how many columns are displayed?', N'PRJ311', CAST(N'2021-03-04 14:41:17.507' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (10, N'The default layout out of a contentPane in a JFrame is __________.', N'PRJ311', CAST(N'2021-03-04 14:42:08.210' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (11, N'To create a JPanel of the BorderLayout, use ______________.', N'PRJ311', CAST(N'2021-03-04 14:43:06.760' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (12, N'To add a component c to a JPanel p, use _________.', N'PRJ311', CAST(N'2021-03-04 14:44:04.527' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (13, N'The method __________ sets the font (Helvetica, 20-point bold) in component C.', N'PRJ311', CAST(N'2021-03-04 14:44:58.923' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (14, N'To specify a font to be bold and italic, use the font style value _________', N'PRJ311', CAST(N'2021-03-04 14:45:48.560' AS DateTime), N'active')
INSERT [dbo].[tbl_Question] ([id], [question_content], [subjectID], [createDate], [status]) VALUES (15, N'JSP ________ let you insert arbitrary code into the servlet''s _JspService method (which is called by service).', N'PRJ311', CAST(N'2021-03-04 14:49:24.137' AS DateTime), N'active')
SET IDENTITY_INSERT [dbo].[tbl_Question] OFF
SET IDENTITY_INSERT [dbo].[tbl_Quiz] ON 

INSERT [dbo].[tbl_Quiz] ([id], [userID], [subjectID], [mark], [time]) VALUES (1, N'Chan@exo', N'PRJ311', 6, CAST(N'2021-03-06 11:31:36.757' AS DateTime))
INSERT [dbo].[tbl_Quiz] ([id], [userID], [subjectID], [mark], [time]) VALUES (2, N'Chan@exo', N'PRJ311', 4, CAST(N'2021-03-06 13:37:53.980' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_Quiz] OFF
INSERT [dbo].[tbl_Subject] ([id], [name]) VALUES (N'PRJ311', N'Java Desktop')
INSERT [dbo].[tbl_Subject] ([id], [name]) VALUES (N'PRJ321', N'Java Web')
INSERT [dbo].[tbl_Users] ([id], [name], [password], [role], [status]) VALUES (N'Chan@exo', N'Chanyeol', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3000000000000000000000000000000000000, N'Student', N'New')
INSERT [dbo].[tbl_Users] ([id], [name], [password], [role], [status]) VALUES (N'haltse140593@gmail.com', N'LuongThanhHa', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3000000000000000000000000000000000000, N'Admin', N'New')
USE [master]
GO
ALTER DATABASE [DB_QuizOnline] SET  READ_WRITE 
GO
