USE [master]
GO
DROP DATABASE IF EXISTS [PRJ301_WORKSHOP1]
GO

CREATE DATABASE [PRJ301_WORKSHOP1]
GO

USE [PRJ301_WORKSHOP1]
GO


CREATE TABLE [dbo].[tblUsers] (
    [Username] VARCHAR(50) NOT NULL,
    [Name] VARCHAR(100) NOT NULL,
    [Password] VARCHAR(255) NOT NULL,
    [Role] VARCHAR(20) NOT NULL CHECK ([Role] IN ('Founder', 'Team Member')),
    CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED ([Username] ASC)
)
GO


INSERT INTO tblUsers (Username, Name, Password, Role) VALUES 
('admin', 'Alice Founder', 'admin123', 'Founder'),
('john_doe', 'John Doe', 'pass123', 'Team Member'),
('jane_f', 'Jane Founder', 'secure456', 'Founder'),
('bob_tm', 'Bob Nguyen', 'abc123', 'Team Member'),
('lisa_tm', 'Lisa Tran', 'xyz789', 'Team Member'),
('david_f', 'David Pham', 'david321', 'Founder'),
('eva_tm', 'Eva Le', 'evapass', 'Team Member'),
('mike_tm', 'Mike Hoang', 'mikepass', 'Team Member'),
('susan_f', 'Susan Bui', 'susanpw', 'Founder'),
('tony_tm', 'Tony Ngo', 'tonypass', 'Team Member')
GO


CREATE TABLE [dbo].[tblStartupProjects] (
    [project_id] INT NOT NULL IDENTITY(1,1),
    [project_name] VARCHAR(100) NOT NULL,
    [Description] TEXT,
    [Status] VARCHAR(20) NOT NULL CHECK ([Status] IN ('Ideation', 'Development', 'Launch', 'Scaling')),
    [estimated_launch] DATE NOT NULL,
    CONSTRAINT [PK_tblStartupProjects] PRIMARY KEY CLUSTERED ([project_id] ASC)
)
GO


INSERT INTO tblStartupProjects (project_name, Description, Status, estimated_launch) VALUES
('EduTech Platform', 'An educational platform for remote learning', 'Ideation', '2025-07-01'),
('HealthPlus', 'A health tracking mobile app', 'Development', '2025-08-15'),
('GreenEnergy', 'Startup focusing on clean energy solutions', 'Ideation', '2025-09-10'),
('QuickShop', 'A fast online shopping experience', 'Launch', '2025-06-30'),
('FarmConnect', 'Connecting farmers with urban buyers', 'Development', '2025-08-01'),
('FitTrack', 'Fitness app using AI coaching', 'Scaling', '2025-10-05'),
('LocalTours', 'Tour booking service for local guides', 'Launch', '2025-07-20'),
('JobLink', 'Job search and resume-building tool', 'Development', '2025-09-01'),
('SafeHome', 'Smart home safety system', 'Scaling', '2025-11-12'),
('FinWise', 'Personal finance management app', 'Ideation', '2025-12-01')
GO
