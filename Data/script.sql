USE [master]
GO
/****** Object:  Database [ArticleManager]    Script Date: 2017/1/3 11:45:05 ******/
CREATE DATABASE [ArticleManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ArticleManager', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ArticleManager.mdf' , SIZE = 14336KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ArticleManager_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ArticleManager_1.ldf' , SIZE = 9216KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ArticleManager] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ArticleManager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ArticleManager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ArticleManager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ArticleManager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ArticleManager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ArticleManager] SET ARITHABORT OFF 
GO
ALTER DATABASE [ArticleManager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ArticleManager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ArticleManager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ArticleManager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ArticleManager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ArticleManager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ArticleManager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ArticleManager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ArticleManager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ArticleManager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ArticleManager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ArticleManager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ArticleManager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ArticleManager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ArticleManager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ArticleManager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ArticleManager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ArticleManager] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ArticleManager] SET  MULTI_USER 
GO
ALTER DATABASE [ArticleManager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ArticleManager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ArticleManager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ArticleManager] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ArticleManager] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ArticleManager', N'ON'
GO
USE [ArticleManager]
GO
/****** Object:  UserDefinedFunction [dbo].[GetArticleTitleById]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 2015年9月14日15:17:42
-- Description:	根据文章id获取标题
-- =============================================
Create FUNCTION [dbo].[GetArticleTitleById]
(
	@Id int
)
RETURNS varchar(200)
AS
BEGIN
declare @Title varchar(200)
select  @Title=Title FROM [Article] where Id=@Id
	return @Title 

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetNickNameByUserId]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 2015年9月14日15:17:42
-- Description:	根据用户id获取用户昵称
-- =============================================
CREATE FUNCTION [dbo].[GetNickNameByUserId]
(
	@UserId int
)
RETURNS varchar(100)
AS
BEGIN
declare @NickName varchar(100)
select  @NickName=ISNULL(NickName,Name) FROM [User] where Id=@UserId
	return @NickName 

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetPositionNameByCode]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 2016年11月17日15:04:27
-- Description:	根据位置代码获取位置名称
-- =============================================
Create FUNCTION [dbo].[GetPositionNameByCode]
(
	@Code int
)
RETURNS varchar(100)
AS
BEGIN
declare @Name varchar(100)
select  @Name=Name FROM Area where Code=@Code
	return @Name 

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetRoleNameByRoleId]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 2015年5月14日13:47:32
-- Description:	根据类型id获取角色名称
-- =============================================
Create FUNCTION [dbo].[GetRoleNameByRoleId]
(
	@RoleId int
)
RETURNS varchar(100)
AS
BEGIN
declare @RoleName varchar(100)
select  @RoleName=RName FROM Role where Id=@RoleId
	return @RoleName 

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetTypeNameByTypeId]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 2015年5月14日13:47:32
-- Description:	根据类型id获取类型名称
-- =============================================
Create FUNCTION [dbo].[GetTypeNameByTypeId]
(
	@TypeId int
)
RETURNS varchar(100)
AS
BEGIN
declare @TypeName varchar(100)
select  @TypeName=Name FROM ArticleType where Id=@TypeId
	return @TypeName 

END

GO
/****** Object:  Table [dbo].[AdminLog]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdminLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL CONSTRAINT [DF_AdminLog_UserId]  DEFAULT ((0)),
	[Controllers] [varchar](50) NOT NULL,
	[Action] [varchar](50) NOT NULL,
	[Parameter] [text] NULL,
	[ActionId] [varchar](50) NULL,
	[Ip] [varchar](20) NOT NULL,
	[Url] [varchar](500) NOT NULL,
	[InTime] [datetime] NOT NULL CONSTRAINT [DF_AdminLog_InTime]  DEFAULT (getdate()),
	[Method] [varchar](10) NOT NULL CONSTRAINT [DF_AdminLog_Method]  DEFAULT ((0)),
	[IsAjax] [bit] NOT NULL CONSTRAINT [DF_AdminLog_IsAjax]  DEFAULT ((0)),
	[UserAgent] [varchar](500) NULL,
	[ControllersDsc] [nvarchar](50) NULL,
	[ActionDsc] [nvarchar](50) NULL,
 CONSTRAINT [PK_AdminLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Area]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Area](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [int] NOT NULL,
	[PinYin] [varchar](50) NOT NULL,
	[SortPinYin] [varchar](10) NOT NULL,
	[Sort] [varchar](10) NOT NULL,
	[ParentCode] [int] NOT NULL CONSTRAINT [DF_Area_ParentCode]  DEFAULT ((0)),
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Article]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Content] [text] NOT NULL,
	[Type] [int] NOT NULL CONSTRAINT [DF_Article_Type]  DEFAULT ((0)),
	[CommentNum] [int] NOT NULL CONSTRAINT [DF_Article_CommentNum]  DEFAULT ((0)),
	[Dot] [int] NOT NULL CONSTRAINT [DF_Article_Dot]  DEFAULT ((0)),
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_Article_CreateTime]  DEFAULT (getdate()),
	[UserId] [int] NOT NULL CONSTRAINT [DF_Article_UserId]  DEFAULT ((0)),
	[ImgNum] [int] NOT NULL CONSTRAINT [DF_Article_ImgNum]  DEFAULT ((0)),
	[AttachmentNum] [int] NOT NULL CONSTRAINT [DF_Article_AttachmentNum]  DEFAULT ((0)),
	[LastEditUserId] [int] NOT NULL CONSTRAINT [DF_Article_LaseEditUserId]  DEFAULT ((0)),
	[LastEditTime] [datetime] NOT NULL CONSTRAINT [DF_Article_LastEditTime]  DEFAULT (getdate()),
	[Guid] [uniqueidentifier] NOT NULL,
	[IsDelete] [bit] NOT NULL CONSTRAINT [DF_Article_IsDelete]  DEFAULT ((0)),
	[State] [smallint] NOT NULL CONSTRAINT [DF_Article_State]  DEFAULT ((0)),
	[RefuseReason] [nvarchar](200) NULL,
	[BType] [smallint] NOT NULL CONSTRAINT [DF_Article_BType]  DEFAULT ((1)),
	[DianZanNum] [int] NOT NULL CONSTRAINT [DF_Article_DianZanNum]  DEFAULT ((0)),
	[Score] [int] NOT NULL CONSTRAINT [DF_Article_Score]  DEFAULT ((0)),
	[IsStick] [bit] NOT NULL CONSTRAINT [DF_Article_IsStick]  DEFAULT ((0)),
	[IsJiaJing] [bit] NOT NULL CONSTRAINT [DF_Article_IsJiaJing]  DEFAULT ((0)),
	[IsCloseComment] [bit] NOT NULL CONSTRAINT [DF_Article_IsCloseComment]  DEFAULT ((0)),
	[CloseCommentReason] [nvarchar](200) NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Article_HotField]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article_HotField](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AId] [bigint] NOT NULL,
	[Dot] [bigint] NOT NULL,
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Article_HotField_UpdateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_Article_HotField] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ArticleType]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ArticleType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[PId] [int] NOT NULL CONSTRAINT [DF_ArticleType_PId]  DEFAULT ((0)),
	[Sort] [int] NOT NULL,
	[PinYin] [varchar](200) NOT NULL,
	[IsHomeMenu] [bit] NOT NULL CONSTRAINT [DF_ArticleType_IsHomeMenu]  DEFAULT ((0)),
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_ArticleType_CreateTime]  DEFAULT (getdate()),
	[Ico] [varchar](100) NULL,
	[IsShow] [bit] NOT NULL CONSTRAINT [DF_ArticleType_IsShow]  DEFAULT ((0)),
 CONSTRAINT [PK_ArticleType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Attachment](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](50) NOT NULL,
	[FileTitle] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Type] [varchar](10) NOT NULL,
	[Width] [int] NOT NULL CONSTRAINT [DF_Table_1_width]  DEFAULT ((0)),
	[Height] [int] NOT NULL CONSTRAINT [DF_Table_1_height]  DEFAULT ((0)),
	[FileSize] [bigint] NOT NULL CONSTRAINT [DF_Attachment_FileSize]  DEFAULT ((0)),
	[IsShow] [bit] NOT NULL CONSTRAINT [DF_Attachment_IsShow]  DEFAULT ((0)),
	[AId] [bigint] NOT NULL CONSTRAINT [DF_Attachment_AId]  DEFAULT ((0)),
	[Score] [int] NOT NULL CONSTRAINT [DF_Attachment_Score]  DEFAULT ((0)),
	[State] [int] NOT NULL CONSTRAINT [DF_Attachment_State]  DEFAULT ((0)),
	[UserId] [int] NOT NULL CONSTRAINT [DF_Attachment_UserId]  DEFAULT ((0)),
	[InTime] [datetime] NOT NULL CONSTRAINT [DF_Attachment_InTime]  DEFAULT (getdate()),
	[BType] [int] NOT NULL CONSTRAINT [DF_Attachment_BType]  DEFAULT ((0)),
	[LocalPath] [varchar](200) NULL,
	[VirtualPath] [varchar](200) NULL,
	[Guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Attachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comment](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AId] [bigint] NOT NULL,
	[UserId] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[Content] [text] NOT NULL,
	[IP] [varchar](20) NOT NULL,
	[UserAgent] [varchar](500) NOT NULL,
	[State] [smallint] NOT NULL,
	[RefuseReason] [nvarchar](200) NULL,
	[IsDelete] [bit] NOT NULL,
	[LastEditUserId] [int] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[IsStick] [bit] NOT NULL,
	[DianZanNum] [int] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DianZanLog]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DianZanLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MId] [bigint] NOT NULL,
	[CId] [bigint] NOT NULL,
	[UserId] [int] NOT NULL,
	[Ip] [varchar](20) NOT NULL,
	[IsCancel] [bit] NOT NULL CONSTRAINT [DF_DianZanLog_IsCancel]  DEFAULT ((0)),
	[CancelTime] [datetime] NULL CONSTRAINT [DF_DianZanLog_CancelTime]  DEFAULT (getdate()),
	[Type] [smallint] NOT NULL,
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_DianZanLog_CreateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_DianZanLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailTemplate]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Template] [text] NOT NULL,
	[ValueIdentifier] [nvarchar](500) NOT NULL,
	[Explanation] [nvarchar](50) NOT NULL,
	[IsSystem] [bit] NOT NULL CONSTRAINT [DF_EmailTemplate_IsSystem]  DEFAULT ((0)),
	[IsHtml] [bit] NOT NULL CONSTRAINT [DF_EmailTemplate_IsHtml]  DEFAULT ((0)),
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_EmailTemplate_CreateTime]  DEFAULT (getdate()),
	[UserId] [int] NOT NULL CONSTRAINT [DF_EmailTemplate_UserId]  DEFAULT ((0)),
	[LastEditUserId] [int] NULL,
	[LastEditTime] [datetime] NULL,
 CONSTRAINT [PK_EmailTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Modul]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Modul](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModulName] [nvarchar](50) NOT NULL,
	[Controller] [varchar](50) NULL,
	[Action] [varchar](50) NULL,
	[Description] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_Modul_CreateTime]  DEFAULT (getdate()),
	[PId] [int] NOT NULL CONSTRAINT [DF_Modul_PId]  DEFAULT ((0)),
	[OrderId] [int] NOT NULL CONSTRAINT [DF_Modul_OrderId]  DEFAULT ((0)),
	[IsShow] [bit] NOT NULL CONSTRAINT [DF_Modul_IsShow]  DEFAULT ((0)),
	[Priority] [int] NOT NULL CONSTRAINT [DF_Modul_Priority]  DEFAULT ((0)),
	[IsDisplay] [bit] NOT NULL CONSTRAINT [DF_Modul_IsDisplay]  DEFAULT ((0)),
	[Ico] [varchar](100) NULL,
 CONSTRAINT [PK_Modul] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notify]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notify](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FromUserId] [int] NOT NULL,
	[ToUserId] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[IsDelete] [bit] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[IsSystem] [bit] NOT NULL,
	[Content] [nvarchar](2000) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Notify] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RName] [varchar](400) NOT NULL,
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_Role_CreateTime]  DEFAULT (getdate()),
	[IsDel] [bit] NOT NULL CONSTRAINT [DF_Role_IsDel]  DEFAULT ((0)),
	[Description] [nvarchar](500) NULL,
	[IsSuper] [bit] NOT NULL CONSTRAINT [DF_Role_IsSuper]  DEFAULT ((0)),
	[ArticleNeedVerified] [bit] NOT NULL CONSTRAINT [DF_Role_ArticleNeedVerified]  DEFAULT ((0)),
	[CommentNeedVerified] [bit] NOT NULL CONSTRAINT [DF_Role_CommentNeedVerified]  DEFAULT ((0)),
 CONSTRAINT [PK_Role_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role_Modul]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Modul](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MId] [int] NOT NULL,
	[RId] [int] NOT NULL,
 CONSTRAINT [PK_Role_Modul] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SendMailLog]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SendMailLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[SendUserId] [int] NOT NULL,
	[TemplateId] [int] NOT NULL CONSTRAINT [DF_SendMailLog_TemplateId]  DEFAULT ((0)),
	[ToEmail] [varchar](50) NOT NULL,
	[FromEmail] [varchar](50) NOT NULL,
	[Status] [smallint] NOT NULL CONSTRAINT [DF_SendMailLog_Type]  DEFAULT ((0)),
	[Title] [nvarchar](500) NOT NULL,
	[Body] [text] NOT NULL,
	[Ip] [varchar](20) NOT NULL,
	[IsSystem] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_SendMailLog_CreateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_SendMailLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tag]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Tag] [nvarchar](10) NOT NULL,
	[AId] [bigint] NOT NULL,
	[State] [smallint] NOT NULL,
	[Direction] [nvarchar](200) NULL,
	[CreateTime] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(10000,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[NickName] [nvarchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[RoleId] [int] NOT NULL CONSTRAINT [DF_User_RoleId]  DEFAULT ((1)),
	[OnLineTime] [datetime] NULL,
	[ActionTime] [datetime] NULL,
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_User_Info_CreateTime]  DEFAULT (getdate()),
	[Avatar] [varchar](100) NULL,
	[Sex] [smallint] NOT NULL CONSTRAINT [DF_User_Sex]  DEFAULT ((0)),
	[Email] [varchar](50) NOT NULL,
	[EmailStatus] [bit] NOT NULL CONSTRAINT [DF_User_EmailStatus]  DEFAULT ((0)),
	[Score] [bigint] NOT NULL CONSTRAINT [DF_User_Score]  DEFAULT ((0)),
	[ArticleNum] [int] NOT NULL CONSTRAINT [DF_User_ArticleNum]  DEFAULT ((0)),
	[CommentNum] [int] NOT NULL CONSTRAINT [DF_User_CommentNum]  DEFAULT ((0)),
	[Disable] [bit] NOT NULL CONSTRAINT [DF_User_Disable]  DEFAULT ((0)),
	[DisableReason] [nvarchar](200) NULL,
	[QQ] [varchar](15) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserAccessLog]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserAccessLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Url] [varchar](200) NOT NULL,
	[Referer] [varchar](200) NULL,
	[UserAgent] [varchar](500) NULL,
	[UserId] [int] NOT NULL CONSTRAINT [DF_UserAccessLog_UserId]  DEFAULT ((0)),
	[Ip] [varchar](20) NOT NULL,
	[InsertTime] [datetime] NOT NULL CONSTRAINT [DF_UserAccessLog_InsertTime]  DEFAULT (getdate()),
	[Other] [nvarchar](500) NULL,
	[Type] [smallint] NOT NULL CONSTRAINT [DF_UserAccessLog_Type]  DEFAULT ((0)),
 CONSTRAINT [PK_UserAccessLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserActivateToken]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserActivateToken](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Token] [varchar](100) NOT NULL,
	[Status] [bit] NOT NULL CONSTRAINT [DF_UserActivateToken_Status]  DEFAULT ((1)),
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_UserActivateToken_CreateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_UserActivateToken] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserBuyingLog]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserBuyingLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AId] [bigint] NOT NULL,
	[Score] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserOther]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserOther](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PersonalityIntroduce] [nvarchar](500) NULL,
 CONSTRAINT [PK_UserOther] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserPosition]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPosition](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Code] [int] NOT NULL,
	[Type] [smallint] NOT NULL CONSTRAINT [DF_UserPosition_Type]  DEFAULT ((0)),
	[CreateTime] [datetime] NOT NULL CONSTRAINT [DF_UserPosition_CreateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_UserPosition] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserScoreLog]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserScoreLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[Describe] [nvarchar](200) NULL,
	[OldScore] [bigint] NOT NULL,
	[NewScore] [bigint] NOT NULL,
 CONSTRAINT [PK_UserScoreLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_IsDelete]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_LastEditUserId]  DEFAULT ((0)) FOR [LastEditUserId]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_LastEditTime]  DEFAULT (getdate()) FOR [LastEditTime]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_IsStick]  DEFAULT ((0)) FOR [IsStick]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_DianZanNum]  DEFAULT ((0)) FOR [DianZanNum]
GO
ALTER TABLE [dbo].[Notify] ADD  CONSTRAINT [DF_Notify_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[Notify] ADD  CONSTRAINT [DF_Notify_IsDelete]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Notify] ADD  CONSTRAINT [DF_Notify_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Notify] ADD  CONSTRAINT [DF_Notify_IsSystem]  DEFAULT ((0)) FOR [IsSystem]
GO
ALTER TABLE [dbo].[Tag] ADD  CONSTRAINT [DF_Tag_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[Tag] ADD  CONSTRAINT [DF_Tag_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[UserScoreLog] ADD  CONSTRAINT [DF_UserScoreLog_Score]  DEFAULT ((0)) FOR [Score]
GO
ALTER TABLE [dbo].[UserScoreLog] ADD  CONSTRAINT [DF_UserScoreLog_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
/****** Object:  StoredProcedure [dbo].[proc_GetAdminLogPageList]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 06/22/2016 15:48:15
-- Description:	分页获取AdminLog
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetAdminLogPageList] 
	@PageIndex INT,
	@PageSize INT,
	--时间
	@BeginTime DATETIME,
	--支时间
	@EndTime DATETIME,
	--总数据条数
	@TotalCount INT OUTPUT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE 1=1'	
	SET @Sql=''
	
	--时间	
	IF @BeginTime IS NOT NULL AND @BeginTime!=''
	BEGIN
		SET @Condition= @Condition + ' AND [AdminLog].CreateTime >='''+ CONVERT(varchar(20),@BeginTime,120)+''''
	END
	--时间
	IF @EndTime IS NOT NULL AND @EndTime!=''		
	BEGIN
		SET @Condition = @Condition + ' AND [AdminLog].CreateTime <='''+CONVERT(varchar(20),@EndTime,120)+''''
	END

	--数据量
	SET @Sql= @Sql + 'SELECT @TotalCount=COUNT(1) FROM dbo.[AdminLog] '
			+@Condition		
	
	SET @Sql = @Sql + ' SELECT [AdminLog].* FROM (SELECT ROW_NUMBER() OVER(ORDER BY Id desc ) AS RowNum, [AdminLog].*  FROM dbo.[AdminLog]'
			+@Condition	+') [AdminLog] '
	IF @PageIndex IS NOT NULL AND @PageSize IS NOT NULL
	BEGIN
		SET	@Sql+='WHERE  RowNum BETWEEN (@PageIndex-1)*@PageSize+1 AND @PageIndex*@PageSize '
	END
	
	PRINT @Sql
	PRINT @TotalCount
	EXEC sp_executesql @Sql,N'@PageIndex INT,@PageSize INT,@TotalCount INT OUTPUT',@PageIndex,@PageSize,@TotalCount OUTPUT
END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetArticleCountByUserId]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 10/28/2016 10:19:22
-- Description:	获取Article记录数-用于个人主页和个人中心
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetArticleCountByUserId] 
	--文章状态 1 已通过 0所有
	@State INT,
	--用户Id
	@UserId INT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)
	SET @Condition=' WHERE IsDelete=0 '	
	SET @Sql=''
	--状态
	IF @State IS NOT NULL AND @State>-1
	BEGIN
		SET @Condition = @Condition + ' AND [Article].State ='+CONVERT(varchar(2),@State)
	END
	--用户Id
	IF @UserId IS NOT NULL AND @UserId>0	
	BEGIN
		SET @Condition = @Condition + ' AND [Article].UserId ='+CONVERT(varchar(10),@UserId)
	END
		--数据量
	SET @Sql= @Sql + 'SELECT COUNT(1) FROM dbo.[Article] '
			+@Condition		
	PRINT @Sql
	EXEC sp_executesql @Sql
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GetArticlePageList]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 10/28/2016 10:19:22
-- Description:	分页获取Article
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetArticlePageList] 
	@PageIndex INT,
	@PageSize INT,
	--时间
	--@BeginTime DATETIME,
	--结束时间
	--@EndTime DATETIME,
	--类型(自定义类型)
	@Type INT,
	----评论数
	--@CommentNum INT,
	----浏览量
	--@Dot INT,
	----添加时间
	--@CreateTime DATETIME,
	----用户Id
	--@UserId INT,
	----图片数量
	--@ImgNum INT,
	----附件数量
	--@AttachmentNum INT,
	----最后修改用户Id
	--@LastEditUserId INT,
	----最后修改时间
	--@LastEditTime DATETIME,
	----文章唯一标示
	--@Guid UNIQUEIDENTIFIER,
	----是否删除
	--@IsDelete BIT,
	----审核状态 0待审核 1审核通过 2审核未通过
	--@State SMALLINT,
	----拒绝通过原因
	--@RefuseReason NVARCHAR(400),
	--文章类型 0 普通文章 1 问答
	@BType SMALLINT,
	----点赞数
	--@DianZanNum INT,
	----浏览消费积分
	--@Score INT,
	----是否置顶
	--@IsStick BIT,
	--是否加精
	@IsJiaJing INT,
	--总数据条数
	@TotalCount INT OUTPUT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE IsDelete=0 AND State=1'	
	SET @Sql=''
	
	--时间	
	--IF @BeginTime IS NOT NULL AND @BeginTime!=''
	--BEGIN
	--	SET @Condition= @Condition + ' AND [Article].CreateTime >='''+ CONVERT(varchar(20),@BeginTime,120)+''''
	--END
	--时间
	--IF @EndTime IS NOT NULL AND @EndTime!=''		
	--BEGIN
	--	SET @Condition = @Condition + ' AND [Article].CreateTime <='''+CONVERT(varchar(20),@EndTime,120)+''''
	--END
	--分类
	IF @Type IS NOT NULL AND @Type>0	
	BEGIN
		SET @Condition = @Condition + ' AND [Article].Type ='+CONVERT(varchar(10),@Type)
	END
	--类型(自定义类型)
	IF @BType IS NOT NULL AND @BType>0
	BEGIN
		SET @Condition = @Condition + ' AND [Article].BType ='+CONVERT(varchar(10),@BType)
	END
	--是否加精
	IF @IsJiaJing IS NOT NULL AND @IsJiaJing>0	AND @IsJiaJing<=2	
	BEGIN
		SET @IsJiaJing=@IsJiaJing-1
		SET @Condition = @Condition + ' AND [Article].IsJiaJing ='+CONVERT(varchar(10),@IsJiaJing)
	END
	--数据量
	SET @Sql= @Sql + 'SELECT @TotalCount=COUNT(1) FROM dbo.[Article] '
			+@Condition		
	
	SET @Sql = @Sql + ' SELECT [Article].* FROM (SELECT ROW_NUMBER() OVER(ORDER BY IsStick desc,Id desc ) AS RowNum, [Article].*,dbo.GetTypeNameByTypeId([Article].Type) AS TypeName  FROM dbo.[Article]'
			+@Condition	+') [Article] '
	IF @PageIndex IS NOT NULL AND @PageSize IS NOT NULL
	BEGIN
		SET	@Sql+='WHERE  RowNum BETWEEN (@PageIndex-1)*@PageSize+1 AND @PageIndex*@PageSize '
	END
	
	PRINT @Sql
	PRINT @TotalCount
	EXEC sp_executesql @Sql,N'@PageIndex INT,@PageSize INT,@TotalCount INT OUTPUT',@PageIndex,@PageSize,@TotalCount OUTPUT
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GetArticlePageListByUserId]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 10/28/2016 10:19:22
-- Description:	分页获取Article-用于个人主页和个人中心
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetArticlePageListByUserId] 
	@PageIndex INT,
	@PageSize INT,
	--文章状态 -1所有 0待审核 1 已通过 2未通过
	@State INT,
	--用户Id
	@UserId INT,
	--总数据条数
	@TotalCount INT OUTPUT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE IsDelete=0 '	
	SET @Sql=''
	--状态
	IF @State IS NOT NULL AND @State>-1
	BEGIN
		SET @Condition = @Condition + ' AND [Article].State ='+CONVERT(varchar(2),@State)
	END
	--用户Id
	IF @UserId IS NOT NULL AND @UserId>0	
	BEGIN
		SET @Condition = @Condition + ' AND [Article].UserId ='+CONVERT(varchar(10),@UserId)
	END
		--数据量
	--SET @Sql= @Sql + 'SELECT @TotalCount=COUNT(1) FROM dbo.[Article] '
	--		+@Condition		
	
	SET @Sql = @Sql + ' SELECT [Article].* FROM (SELECT ROW_NUMBER() OVER(ORDER BY Id desc ) AS RowNum, [Article].*,dbo.GetTypeNameByTypeId([Article].Type) AS TypeName  FROM dbo.[Article]'
			+@Condition	+') [Article] '
	IF @PageIndex IS NOT NULL AND @PageSize IS NOT NULL
	BEGIN
		SET	@Sql+='WHERE  RowNum BETWEEN (@PageIndex-1)*@PageSize+1 AND @PageIndex*@PageSize '
	END
	
	PRINT @Sql
	PRINT @TotalCount
	--EXEC sp_executesql @Sql,N'@PageIndex INT,@PageSize INT,@TotalCount INT OUTPUT',@PageIndex,@PageSize,@TotalCount OUTPUT
	EXEC sp_executesql @Sql,N'@PageIndex INT,@PageSize INT',@PageIndex,@PageSize
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GetCommentCountByUserId]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 11/17/2016 11:27:07
-- Description:	获取Comment记录数-用于个人主页和个人中心
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetCommentCountByUserId] 
	@UserId INT,
	@State INT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE IsDelete=0'	
	SET @Sql=''
	--状态
	IF @State IS NOT NULL AND @State>-1
	BEGIN
		SET @Condition = @Condition + ' AND [Comment].State ='+CONVERT(varchar(2),@State)
	END
	--用户Id	
	IF @UserId IS NOT NULL AND @UserId>0
	BEGIN
		SET @Condition= @Condition + ' AND [Comment].UserId ='+ CONVERT(varchar(20),@UserId)
	END
		--数据量
	SET @Sql= @Sql + 'SELECT COUNT(1) FROM dbo.[Comment] '
			+@Condition		
	

	PRINT @Sql
	EXEC sp_executesql @Sql
END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetCommentPageList]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 11/17/2016 11:27:07
-- Description:	分页获取Comment
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetCommentPageList] 
	@PageIndex INT,
	@PageSize INT,
	@AId BIGINT,
	@AuthorId INT,
	@Order VARCHAR(5),
	--总数据条数
	@TotalCount INT OUTPUT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE IsDelete=0 AND State=1'	
	SET @Sql=''
	
	--文章id	
	IF @AId IS NOT NULL AND @AId>0
	BEGIN
		SET @Condition= @Condition + ' AND [Comment].AId ='+ CONVERT(varchar(20),@AId)
	END
	--用户id	
	IF @AuthorId IS NOT NULL AND @AuthorId>0
	BEGIN
		SET @Condition= @Condition + ' AND [Comment].UserId ='+ CONVERT(varchar(20),@AuthorId)
	END
	IF @Order IS NOT NULL OR @Order=''
	BEGIN
		 SET @Order='ASC'
	END

	--数据量
	SET @Sql= @Sql + 'SELECT @TotalCount=COUNT(1) FROM dbo.[Comment] '
			+@Condition		
	
	SET @Sql = @Sql + ' SELECT [Comment].* FROM (SELECT ROW_NUMBER() OVER(ORDER BY IsStick desc,Id '+@Order+' ) AS RowNum, [Comment].*  FROM dbo.[Comment]'
			+@Condition	+') [Comment] '
	IF @PageIndex IS NOT NULL AND @PageSize IS NOT NULL
	BEGIN
		SET	@Sql+='WHERE  RowNum BETWEEN (@PageIndex-1)*@PageSize+1 AND @PageIndex*@PageSize '
	END
	
	PRINT @Sql
	PRINT @TotalCount
	EXEC sp_executesql @Sql,N'@PageIndex INT,@PageSize INT,@TotalCount INT OUTPUT',@PageIndex,@PageSize,@TotalCount OUTPUT
END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetCommentPageListByUserId]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 11/17/2016 11:27:07
-- Description:	根据用户ID分页获取Comment-用于个人主页和个人中心
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetCommentPageListByUserId] 
	@PageIndex INT,
	@PageSize INT,
	@UserId INT,
	@State INT,
	--总数据条数
	@TotalCount INT OUTPUT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE IsDelete=0'	
	SET @Sql=''
	--状态
	IF @State IS NOT NULL AND @State>-1
	BEGIN
		SET @Condition = @Condition + ' AND [Comment].State ='+CONVERT(varchar(2),@State)
	END
	--用户Id	
	IF @UserId IS NOT NULL AND @UserId>0
	BEGIN
		SET @Condition= @Condition + ' AND [Comment].UserId ='+ CONVERT(varchar(20),@UserId)
	END
		--数据量
	SET @Sql= @Sql + 'SELECT @TotalCount=COUNT(1) FROM dbo.[Comment] '
			+@Condition		
	
	SET @Sql = @Sql + ' SELECT [Comment].* FROM (SELECT ROW_NUMBER() OVER(ORDER BY Id DESC) AS RowNum, [Comment].*,dbo.GetArticleTitleById([Comment].AId) AS ArticleTitle  FROM dbo.[Comment]'
			+@Condition	+') [Comment] '
	IF @PageIndex IS NOT NULL AND @PageSize IS NOT NULL
	BEGIN
		SET	@Sql+='WHERE  RowNum BETWEEN (@PageIndex-1)*@PageSize+1 AND @PageIndex*@PageSize '
	END
	
	PRINT @Sql
	PRINT @TotalCount
	EXEC sp_executesql @Sql,N'@PageIndex INT,@PageSize INT,@TotalCount INT OUTPUT',@PageIndex,@PageSize,@TotalCount OUTPUT
END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetModulPageList]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 06/22/2016 15:15:48
-- Description:	分页获取Modul
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetModulPageList] 
	@PageIndex INT,
	@PageSize INT,
	--时间
	@BeginTime DATETIME,
	--支时间
	@EndTime DATETIME,
	--总数据条数
	@TotalCount INT OUTPUT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE 1=1'	
	SET @Sql=''
	
	--时间	
	IF @BeginTime IS NOT NULL AND @BeginTime!=''
	BEGIN
		SET @Condition= @Condition + ' AND [Modul].CreateTime >='''+ CONVERT(varchar(20),@BeginTime,120)+''''
	END
	--时间
	IF @EndTime IS NOT NULL AND @EndTime!=''		
	BEGIN
		SET @Condition = @Condition + ' AND [Modul].CreateTime <='''+CONVERT(varchar(20),@EndTime,120)+''''
	END

	--数据量
	SET @Sql= @Sql + 'SELECT @TotalCount=COUNT(1) FROM dbo.[Modul] '
			+@Condition		
	
	SET @Sql = @Sql + ' SELECT [Modul].* FROM (SELECT ROW_NUMBER() OVER(ORDER BY Id desc ) AS RowNum, [Modul].*  FROM dbo.[Modul]'
			+@Condition	+') [Modul] '
	IF @PageIndex IS NOT NULL AND @PageSize IS NOT NULL
	BEGIN
		SET	@Sql+='WHERE  RowNum BETWEEN (@PageIndex-1)*@PageSize+1 AND @PageIndex*@PageSize '
	END
	
	PRINT @Sql
	PRINT @TotalCount
	EXEC sp_executesql @Sql,N'@PageIndex INT,@PageSize INT,@TotalCount INT OUTPUT',@PageIndex,@PageSize,@TotalCount OUTPUT
END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetUserPageList]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 06/22/2016 13:50:11
-- Description:	分页获取User
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetUserPageList] 
	@PageIndex INT,
	@PageSize INT,
	--时间
	@BeginTime DATETIME,
	--支时间
	@EndTime DATETIME,
	--总数据条数
	@TotalCount INT OUTPUT
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE 1=1'	
	SET @Sql=''
	
	--时间	
	IF @BeginTime IS NOT NULL AND @BeginTime!=''
	BEGIN
		SET @Condition= @Condition + ' AND [User].CreateTime >='''+ CONVERT(varchar(20),@BeginTime,120)+''''
	END
	--时间
	IF @EndTime IS NOT NULL AND @EndTime!=''		
	BEGIN
		SET @Condition = @Condition + ' AND [User].CreateTime <='''+CONVERT(varchar(20),@EndTime,120)+''''
	END

	--数据量
	SET @Sql= @Sql + 'SELECT @TotalCount=COUNT(1) FROM dbo.[User] '
			+@Condition		
	
	SET @Sql = @Sql + ' SELECT [User].* FROM (SELECT ROW_NUMBER() OVER(ORDER BY Id desc ) AS RowNum, [User].*  FROM dbo.[User]'
			+@Condition	+') [User] '
	IF @PageIndex IS NOT NULL AND @PageSize IS NOT NULL
	BEGIN
		SET	@Sql+='WHERE  RowNum BETWEEN (@PageIndex-1)*@PageSize+1 AND @PageIndex*@PageSize '
	END
	
	PRINT @Sql
	PRINT @TotalCount
	EXEC sp_executesql @Sql,N'@PageIndex INT,@PageSize INT,@TotalCount INT OUTPUT',@PageIndex,@PageSize,@TotalCount OUTPUT
END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetUsersByIds]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 06/22/2016 13:50:11
-- Description:	根据多个用户id获取多个用户信息
-- =============================================
CREATE PROCEDURE [dbo].[proc_GetUsersByIds] 
	@UserIds varchar(1000)
AS
BEGIN
DECLARE 
		@Sql NVARCHAR(MAX),
		@Condition NVARCHAR(MAX)

	SET @Condition=' WHERE 1=1'	
	SET @Sql=''
	
	--
	IF @UserIds IS NOT NULL AND @UserIds!=''
	BEGIN
		SET @Condition= @Condition + ' AND [User].Id IN ('+ @UserIds +')'
	END
	
	SET @Sql = @Sql + ' SELECT [User].* FROM (SELECT ROW_NUMBER() OVER(ORDER BY Id desc ) AS RowNum, [User].*,dbo.GetRoleNameByRoleId([User].[RoleId]) AS RName  FROM dbo.[User]'
			+@Condition	+') [User] '

	
	PRINT @Sql
	EXEC sp_executesql @Sql
END

GO
/****** Object:  StoredProcedure [dbo].[proc_SyncArticleHotFieldToArticle]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 06/22/2016 15:48:15
-- Description:	定时执行同步文章热字段到主表
-- =============================================
CREATE PROCEDURE [dbo].[proc_SyncArticleHotFieldToArticle] 
AS
BEGIN
	--更新10分钟内有变更的数据
	UPDATE [Article] SET Dot=isnull((select top 1 Dot from [Article_HotField] ah where ah.AId=[Article].Id),0)
	where Id IN(select AID from [Article_HotField] where DATEDIFF(MINUTE,UpdateTime,GETDATE())<=10)
END




GO
/****** Object:  StoredProcedure [dbo].[proc_UpdateArticleDot]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		huhangfei
-- Create date: 06/22/2016 15:48:15
-- Description:	更新文章点击量
-- =============================================
CREATE PROCEDURE [dbo].[proc_UpdateArticleDot] 
	@AId bigint
AS
BEGIN
DECLARE  @Count int=0
Select @Count=count(1) from [Article_HotField] where AId=@AId
	if(@Count>0)
	begin 
	  UPDATE [Article_HotField] SET Dot=Dot+1,UpdateTime=GETDATE() WHERE AId=@AId
	end
	else
	begin 
		insert into [Article_HotField](AId,Dot)values(@AId,1)
	end
END

GO
/****** Object:  StoredProcedure [dbo].[sp_PageView]    Script Date: 2017/1/3 11:45:05 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[sp_PageView]
@tbname      varchar(800),          --sysname,               --要分页显示的表名
@FieldKey   sysname,               --用于定位记录的主键(惟一键)字段,只能是单个字段
@PageCurrent int=1,                 --要显示的页码
@PageSize   int=10,                --每页的大小(记录数)
@FieldShow  nvarchar(4000)='',      --以逗号分隔的要显示的字段列表,如果不指定,则显示所有字段
@FieldOrder  nvarchar(1000)='',     --以逗号分隔的排序字段列表,可以指定在字段后面指定DESC/ASC 用于指定排序顺序
@Where     nvarchar(1000)='',      --查询条件
@PageCount  int OUTPUT,           --总页数
@Count  int OUTPUT                  --总记录数
AS
DECLARE @sql nvarchar(max)
SET NOCOUNT ON
--检查对象是否有效
--IF OBJECT_ID(@tbname) IS NULL
--BEGIN
--    RAISERROR(N'对象"%s"不存在',1,16,@tbname)
--    RETURN
--END
--IF OBJECTPROPERTY(OBJECT_ID(@tbname),N'IsTable')=0
--    AND OBJECTPROPERTY(OBJECT_ID(@tbname),N'IsView')=0
--    AND OBJECTPROPERTY(OBJECT_ID(@tbname),N'IsTableFunction')=0
--BEGIN
--    RAISERROR(N'"%s"不是表、视图或者表值函数',1,16,@tbname)
--    RETURN
--END

--分页字段检查
IF ISNULL(@FieldKey,N'')=''
BEGIN
    RAISERROR(N'分页处理需要主键（或者惟一键）',1,16)
    RETURN
END

--其他参数检查及规范
IF ISNULL(@PageCurrent,0)<1 SET @PageCurrent=1
IF ISNULL(@PageSize,0)<1 SET @PageSize=10
IF ISNULL(@FieldShow,N'')=N'' SET @FieldShow=N'*'
IF ISNULL(@FieldOrder,N'')=N''
    SET @FieldOrder=N''
ELSE
    SET @FieldOrder=N'ORDER BY '+LTRIM(@FieldOrder)
IF ISNULL(@Where,N'')=N''
    SET @Where=N''
ELSE
    SET @Where=N'WHERE ('+@Where+N')'

--如果@PageCount为NULL值,则计算总页数(这样设计可以只在第一次计算总页数,以后调用时,把总页数传回给存储过程,避免再次计算总页数,对于不想计算总页数的处理而言,可以给@PageCount赋值)
IF @PageCount IS NULL
BEGIN
    SET @sql=N'SELECT @PageCount=COUNT(*)'
        +N' FROM '+@tbname
        +N' '+@Where
    EXEC sp_executesql @sql,N'@PageCount int OUTPUT',@PageCount OUTPUT
    SET @Count=@PageCount
    SET @PageCount=(@PageCount+@PageSize-1)/@PageSize
END

--判断当前显示页面是否大于总页数，如果大于，当前页设置为1
if @PageCurrent>@PageCount 
    set @PageCurrent=1

--计算分页显示的TOPN值
DECLARE @TopN varchar(20),@TopN1 varchar(20)
SELECT @TopN=@PageSize,
    @TopN1=@PageCurrent*@PageSize    

--第一页直接显示
IF @PageCurrent=1
    EXEC(N'SELECT TOP '+@TopN
        +N' '+@FieldShow
        +N' FROM '+@tbname
        +N' '+@Where
        +N' '+@FieldOrder)
ELSE
BEGIN
    SELECT @PageCurrent=@TopN1,
        @sql=N'SELECT @n=@n-1,@s=CASE WHEN @n<'+@TopN
            +N' THEN @s+N'',''+QUOTENAME(RTRIM(CAST('+@FieldKey
            +N' as varchar(8000))),N'''''''') ELSE N'''' END FROM '+@tbname
            +N' '+@Where
            +N' '+@FieldOrder
    SET ROWCOUNT @PageCurrent
    EXEC sp_executesql @sql,
        N'@n int,@s nvarchar(4000) OUTPUT',
        @PageCurrent,@sql OUTPUT
    SET ROWCOUNT 0
    IF @sql=N''
        EXEC(N'SELECT TOP 0'
            +N' '+@FieldShow
            +N' FROM '+@tbname)
    ELSE
    BEGIN
        SET @sql=STUFF(@sql,1,1,N'')        
        --执行查询
        EXEC(N'SELECT TOP '+@TopN
            +N' '+@FieldShow
            +N' FROM '+@tbname
            +N' WHERE '+@FieldKey
            +N' IN('+@sql
            +N') '+@FieldOrder)
    END
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问控制器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'Controllers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问Action' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'Action'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'Parameter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求中主要ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'ActionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'Ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Url' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'Url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'InTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求方法 get/post....' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'Method'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是Ajax访问' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'IsAjax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UserAgent' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'UserAgent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'控制器描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'ControllersDsc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminLog', @level2type=N'COLUMN',@level2name=N'ActionDsc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'Content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型(自定义类型)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'CommentNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浏览量(有延迟，实时数据在aiticle_hotfield中)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'Dot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'ImgNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'AttachmentNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'LastEditUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'LastEditTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章唯一标示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'Guid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'IsDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核状态 0待审核 1审核通过 2审核未通过' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'拒绝通过原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'RefuseReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章类型 :  1 普通文章 ,2 问答' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'BType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'点赞数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'DianZanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浏览消费积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否置顶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'IsStick'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否加精' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'IsJiaJing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否关闭评论' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'IsCloseComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关闭评论原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article', @level2type=N'COLUMN',@level2name=N'CloseCommentReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article_HotField', @level2type=N'COLUMN',@level2name=N'AId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实时点击量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Article_HotField', @level2type=N'COLUMN',@level2name=N'Dot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型父级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'PId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'拼音' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'PinYin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是主页菜单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'IsHomeMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'前台图标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'Ico'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'前台发布时可选' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArticleType', @level2type=N'COLUMN',@level2name=N'IsShow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件存储名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件原名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'FileTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'img 宽' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'Width'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'img 高' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'Height'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'FileSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否显示0 不显示 1显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'IsShow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属文章Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'AId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件来源（用于记录程序中各个上传口）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态 0 初始状态 1已审核通过 2审核未通过（用于文件审核）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'InTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0附件 1图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'BType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件存储绝对路径（暂时无用）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'LocalPath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件相对目录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'VirtualPath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传唯一标示(上传页面初始化后产生)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attachment', @level2type=N'COLUMN',@level2name=N'Guid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'AId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'Content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论者Ip' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'IP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户UA信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'UserAgent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核状态0待审核 1已通过 2未通过' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'拒绝原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'RefuseReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'IsDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改用户 0默认' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'LastEditUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'LastEditTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否置顶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'IsStick'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'点赞数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'COLUMN',@level2name=N'DianZanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主体Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DianZanLog', @level2type=N'COLUMN',@level2name=N'MId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'次级主键Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DianZanLog', @level2type=N'COLUMN',@level2name=N'CId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DianZanLog', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ip' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DianZanLog', @level2type=N'COLUMN',@level2name=N'Ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否取消' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DianZanLog', @level2type=N'COLUMN',@level2name=N'IsCancel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型 1文章 2评论' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DianZanLog', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DianZanLog', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮件标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'Template'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板值的标识符 例如：($UserName;$UserId)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'ValueIdentifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'Explanation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是系统邮件模板' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'IsSystem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是html' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'IsHtml'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改人Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'LastEditUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailTemplate', @level2type=N'COLUMN',@level2name=N'LastEditTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'ModulName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问控制器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'Controller'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问Action' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'Action'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父级Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'PId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'OrderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否开启该模块' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'IsShow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'优先级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'Priority'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'IsDisplay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单图标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modul', @level2type=N'COLUMN',@level2name=N'Ico'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Notify', @level2type=N'COLUMN',@level2name=N'FromUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'接受者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Notify', @level2type=N'COLUMN',@level2name=N'ToUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Notify', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Notify', @level2type=N'COLUMN',@level2name=N'IsDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已读' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Notify', @level2type=N'COLUMN',@level2name=N'IsRead'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是系统消息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Notify', @level2type=N'COLUMN',@level2name=N'IsSystem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'RName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否禁用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'IsDel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是超级角色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'IsSuper'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发帖是否需要审核' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'ArticleNeedVerified'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论是否需要审核' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role', @level2type=N'COLUMN',@level2name=N'CommentNeedVerified'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role_Modul', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role_Modul', @level2type=N'COLUMN',@level2name=N'MId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Role_Modul', @level2type=N'COLUMN',@level2name=N'RId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'接收用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'SendUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮件模板Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'TemplateId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'接收人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'ToEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送人邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'FromEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮件发送状态 0 未知 1成功 2 失败' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮件标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮件内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'Body'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是系统邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'IsSystem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SendMailLog', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标签' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tag', @level2type=N'COLUMN',@level2name=N'Tag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tag', @level2type=N'COLUMN',@level2name=N'AId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态 0待审核 1审核通过 2审核未通过' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tag', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tag', @level2type=N'COLUMN',@level2name=N'Direction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tag', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tag', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'NickName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'RoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后在线时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'OnLineTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后操作时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'ActionTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'头像' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Avatar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别 0 未知 1男 2女' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Sex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email是否激活' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'EmailStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'ArticleNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回复数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'CommentNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Disable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁用原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'DisableReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'QQ号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'QQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'Url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'Referer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UA' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'UserAgent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ip' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'Ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'InsertTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'其它信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'Other'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型 0后台记录 1js记录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserAccessLog', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserActivateToken', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'激活邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserActivateToken', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'令牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserActivateToken', @level2type=N'COLUMN',@level2name=N'Token'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否有效' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserActivateToken', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'写入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserActivateToken', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserBuyingLog', @level2type=N'COLUMN',@level2name=N'AId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'花费积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserBuyingLog', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserBuyingLog', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserOther', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'个性介绍' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserOther', @level2type=N'COLUMN',@level2name=N'PersonalityIntroduce'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'位置代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPosition', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型 0省 1城 2区' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPosition', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserScoreLog', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增减值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserScoreLog', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserScoreLog', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserScoreLog', @level2type=N'COLUMN',@level2name=N'Describe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增减前分值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserScoreLog', @level2type=N'COLUMN',@level2name=N'OldScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增减后分值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserScoreLog', @level2type=N'COLUMN',@level2name=N'NewScore'
GO
USE [master]
GO
ALTER DATABASE [ArticleManager] SET  READ_WRITE 
GO
