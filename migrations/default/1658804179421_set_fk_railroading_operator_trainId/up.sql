alter table "railroading"."operator"
  add constraint "operator_trainId_fkey"
  foreign key ("trainId")
  references "railroading"."train"
  ("id") on update restrict on delete restrict;
