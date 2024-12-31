
create or replace function crear_sector(lon float, lat float, azimuth float, distance integer, width integer)
returns geometry
language plpgsql
as
$$
declare
   sector geometry;
begin
    sector = ST_MakePolygon(ST_MakeLine(ARRAY[ST_SetSRID(ST_MakePoint(lon,lat),4326),
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth-(width/2))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth-(width/2-1*(width/2/5)))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth-(width/2-2*(width/2/5)))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth-(width/2-3*(width/2/5)))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth-(width/2-4*(width/2/5)))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth)/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth+(width/2-4*(width/2/5)))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth+(width/2-3*(width/2/5)))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth+(width/2-2*(width/2/5)))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth+(width/2-1*(width/2/5)))/180.0)::geometry,
                ST_Project(ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography, distance, pi()*(azimuth+(width/2))/180.0)::geometry,                                   
                ST_SetSRID(ST_MakePoint(lon,lat),4326)  
                     ]));
   return sector;
end;
$$;