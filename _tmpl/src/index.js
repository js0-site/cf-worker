export default {
  async fetch(req) {
    const url = new URL(req.url);
    url.pathname = "/__scheduled";
    url.searchParams.append("cron", "* * * * *");
    return new Response("");
  },

<<<<<<< HEAD:_tmpl/src/index.js
  async scheduled(_event, env, _ctx) {
||||||| e0bb4ed:status-smtp/src/index.js
  async scheduled(_event, { SMTP_PASSWORD, SMTP_USER }, _ctx) {
    const li = await smtpCheck("smtp.js0.site", SMTP_USER, SMTP_PASSWORD);
=======
  async scheduled(_event, { SMTP_PASSWORD, SMTP_USER }, _ctx) {
    console.log(SMTP_USER);
    const li = await smtpCheck("smtp.js0.site", SMTP_USER, SMTP_PASSWORD);
>>>>>>> origin/main:status-smtp/src/index.js
    console.log(li);
  },
};
