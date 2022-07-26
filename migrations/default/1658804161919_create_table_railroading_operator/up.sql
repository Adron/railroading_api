CREATE TABLE "railroading"."operator" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "trainId" uuid NOT NULL, "railroadId" uuid NOT NULL, "details" text NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("railroadId") REFERENCES "railroading"."railroad"("id") ON UPDATE restrict ON DELETE restrict);
CREATE OR REPLACE FUNCTION "railroading"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_railroading_operator_updated_at"
BEFORE UPDATE ON "railroading"."operator"
FOR EACH ROW
EXECUTE PROCEDURE "railroading"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_railroading_operator_updated_at" ON "railroading"."operator" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;
