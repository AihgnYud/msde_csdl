USE [ASMS_TST_NEW]
GO

/****** Object:  Table [dbo].[RelativeProfile]    Script Date: 8/20/2026 5:10:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RelativeProfile](
	[Id] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[CategoryOrganizationId] [bigint] NULL,
	[CategoryObjectId] [smallint] NOT NULL,
	[CategoryFamilyRelationshipId] [smallint] NULL,
	[CategoryNationalityId] [smallint] NULL,
	[CategoryNationId] [smallint] NULL,
	[CategoryHospitalId] [smallint] NULL,
	[CategoryMedicalObjectId] [smallint] NULL,
	[CategoryMedicalBlockId] [smallint] NULL,
	[IsPrioritizeMedicalObject] [bit] NULL,
	[IsPrioritizeMedicalBlock] [bit] NULL,
	[CollectionObjectType] [varchar](2) NULL,
	[UserId] [nvarchar](450) NULL,
	[ApproveUserId] [nvarchar](450) NULL,
	[LastModifiedUserId] [nvarchar](450) NULL,
	[LastModifiedApproveUserId] [nvarchar](450) NULL,
	[ApproveDate] [date] NULL,
	[LastModifiedApproveDate] [date] NULL,
	[Status] [tinyint] NOT NULL,
	[SiBookNum] [varchar](12) NULL,
	[MiCardNum] [varchar](20) NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[NormalizedFullName] [varchar](100) NOT NULL,
	[Sex] [char](1) NOT NULL,
	[IsOnlyBirthYear] [tinyint] NULL,
	[DateOfBirth] [date] NOT NULL,
	[BirthAddress] [nvarchar](255) NULL,
	[BirthProvinceId] [smallint] NULL,
	[BirthDistrictId] [smallint] NULL,
	[BirthCommuneId] [smallint] NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[ContactAddress] [nvarchar](255) NULL,
	[ContactProvinceId] [smallint] NULL,
	[ContactDistrictId] [smallint] NULL,
	[ContactCommuneId] [smallint] NULL,
	[Email] [varchar](100) NULL,
	[IdCardNumber] [varchar](15) NULL,
	[IdCardIssuedAddress] [nvarchar](255) NULL,
	[IdCardIssuedDate] [date] NULL,
	[LivingAreaCode] [varchar](5) NULL,
	[Note] [nvarchar](255) NULL,
	[PersonalProfileId] [bigint] NULL,
	[PersonalProfileAllId] [bigint] NULL,
	[RelativeProfileAllId] [bigint] NULL,
	[CollectionOperationArriveDocumentDtlId] [bigint] NULL,
	[IsGenerateNewCode] [bit] NULL,
	[VerifiedByMoPS] [bit] NULL,
	[SiBookNumTemp] [varchar](12) NULL,
	[CategoryCreatedOrganizationId] [bigint] NULL,
	[CategoryCauseOfDeathId] [smallint] NULL,
	[PersonalType] [smallint] NULL,
	[TypeArriveDocument] [nvarchar](50) NULL,
	[newid] [bigint] NULL,
	[SwitchSiBookNumIp] [varchar](50) NULL,
	[IsDuplicateIdCardNumber] [bit] NULL,
	[SwitchSiBookNumStatus] [tinyint] NULL,
	[SiBookNumOld] [varchar](12) NULL,
	[OverAgeType] [tinyint] NULL,
	[SkipMoPSVerification] [bit] NULL,
 CONSTRAINT [PK_RelativeProfile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


