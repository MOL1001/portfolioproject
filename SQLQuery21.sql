SELECT *
 From [dbo].[CovidDeaths1]
 Where continent is not null
 Order by 3,4               

 --SELECT *
 --From [dbo].[CovidVacinations1]
 --order by 3,4

 --select data that are going to be using

 Select Location, date ,total_cases, new_cases, total_deaths, population 
 from [dbo].[CovidDeaths1]
 Where continent is not null
  order by 1,2

  -- Looking at Total Cases vs Total Deaths
  --shows likelihood of dying if you contract covid in your country
 Select Location, date ,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 from [dbo].[CovidDeaths1]
 Where location like'%states%'
 and continent is not null
  order by 1,2


  -- Looking at countries with Highest infection Rate compared to population

  Select Location, population, Max(total_cases) as highestinfectioncount, Max ((total_cases/population))*100 as
  PercentPopulationInfected
 from [dbo].[CovidDeaths1]
-- Where location like'%states%'
 Group by Location, population
  order by  PercentPopulationInfected desc

  -- Showing Countries With Highest Death Count per Population

  Select Location, Max(cast (Total_deaths as int)) as TotalDeathCount
 from [dbo].[CovidDeaths1]
-- Where location like'%states%'
Where continent is not null
 Group by Location, population
  order by  TotalDeathCount desc


--LET'S BREAK THINGS DOWN BY CONTINENT

Select continent, Max(cast (Total_deaths as int)) as TotalDeathCount
From [dbo].[CovidDeaths1]
-- Where location like'%states%'
Where continent is not null
Group by continent
order by  TotalDeathCount desc

--LET'S BREAK THINGS DOWN BY CONTINENT
 
--Showing continent with the highest deaths count per population

Select continent, Max(cast (Total_deaths as int)) as TotalDeathCount
From [dbo].[CovidDeaths1]
-- Where location like'%states%'
Where continent is not null
Group by continent
order by  TotalDeathCount desc



-- GLOBAL NUMBERS




--Looking at Total Population VS Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_Vaccinations
, SUM(Cast(vac.new_Vaccinations as int)) over (partition by dea.Location)
From[dbo].[CovidDeaths1] dea
Join [dbo].[CovidVacinations1] vac
    On dea.location = Vac.location
	and dea.date = Vac.date
	where dea.continent is not null
	order by 2,3
 