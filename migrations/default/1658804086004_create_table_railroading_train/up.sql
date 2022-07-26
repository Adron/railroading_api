CREATE TABLE "railroading"."train" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, "historical_start" date NOT NULL, "historical_end" date NOT NULL, "description" text NOT NULL, "notes" text NOT NULL, PRIMARY KEY ("id") , UNIQUE ("name"));
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
CREATE TRIGGER "set_railroading_train_updated_at"
BEFORE UPDATE ON "railroading"."train"
FOR EACH ROW
EXECUTE PROCEDURE "railroading"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_railroading_train_updated_at" ON "railroading"."train" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;
