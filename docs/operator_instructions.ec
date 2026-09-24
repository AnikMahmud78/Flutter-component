=== BINARY ENGLISH CODE RUNBOOK: GEN-02336 ===

1. VERIFY Environment Configuration:
   IF NPM_TOKEN IS NULL THEN ABORT WITH ERROR "Missing Auth Token".
   IF NPM_TOKEN IS PRESENT THEN PROCEED TO STEP 2.

2. BUILD Application Package:
   EXECUTE "flutter build apk --release".
   IF EXIT_CODE != 0 THEN ABORT WITH ERROR "Build Failure".
   IF EXIT_CODE == 0 THEN PROCEED TO STEP 3.

3. VALIDATE Runtime Liveness:
   PING "https://api.habot.io/liveness".
   IF RESPONSE != 200 THEN ROLLBACK ENVIRONMENT.
   IF RESPONSE == 200 THEN COMMIT RUNBOOK TO PASS.
