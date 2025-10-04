USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[SavedPosts]    Script Date: 3/10/2025 12:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-------------------------------------------------------------
--===============| Create SavedPosts Table |===============--
CREATE TABLE [dbo].[SavedPosts](

	[saved_post_id] [int] IDENTITY(1,1) NOT NULL,
	[account_id]	[int]				NOT NULL,
	[post_id]		[int]				NOT NULL,
	[saved_at]		[datetime]			NOT NULL	DEFAULT (getdate()),

	-- PK
	CONSTRAINT [PK_SavedPosts_SavedPostID] PRIMARY KEY CLUSTERED 
		([saved_post_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- UQ
	CONSTRAINT [UQ_SavedPosts_AccountID_PostID] UNIQUE NONCLUSTERED (account_id,post_id) 
		WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
		ON [PRIMARY],

	-- FK
	CONSTRAINT [FK_SavedPosts_BlogPosts] FOREIGN KEY([post_id])
		REFERENCES [dbo].[BlogPosts] ([post_id])
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	-- FK
	CONSTRAINT [FK_SavedPosts_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id])
		ON DELETE CASCADE

) ON [PRIMARY]
GO


---------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_SavedPosts_AccountID] 
	ON [dbo].[SavedPosts]
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


---------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_SavedPosts_PostID] 
	ON [dbo].[SavedPosts]
	([post_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'saved_at' : USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[SavedPosts]    Script Date: 3/10/2025 12:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-------------------------------------------------------------
--===============| Create SavedPosts Table |===============--
CREATE TABLE [dbo].[SavedPosts](

	[saved_post_id] [int] IDENTITY(1,1) NOT NULL,
	[account_id]	[int]				NOT NULL,
	[post_id]		[int]				NOT NULL,
	[saved_at]		[datetime]			NOT NULL	DEFAULT (getdate()),

	-- PK
	CONSTRAINT [PK_SavedPosts_SavedPostID] PRIMARY KEY CLUSTERED 
		([saved_post_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- UQ
	CONSTRAINT [UQ_SavedPosts_AccountID_PostID] UNIQUE NONCLUSTERED (account_id,post_id) 
		WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
		ON [PRIMARY],

	-- FK
	CONSTRAINT [FK_SavedPosts_BlogPosts] FOREIGN KEY([post_id])
		REFERENCES [dbo].[BlogPosts] ([post_id])
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	-- FK
	CONSTRAINT [FK_SavedPosts_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id])
		ON DELETE CASCADE

) ON [PRIMARY]
GO


---------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_SavedPosts_AccountID] 
	ON [dbo].[SavedPosts]
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


---------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_SavedPosts_PostID] 
	ON [dbo].[SavedPosts]
	([post_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'saved_at' : Must not be in the future.
--==========================================================--

ALTER TABLE dbo.SavedPosts ADD CONSTRAINT
	CK_SavedPosts_SavedAt 
	CHECK (saved_at <= GETDATE())