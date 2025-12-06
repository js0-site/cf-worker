import smtpCheck from "@3-/smtp_check";

export default {
  async fetch(req) {
    const url = new URL(req.url);
    url.pathname = "/__scheduled";
    url.searchParams.append("cron", "* * * * *");
    return new Response("");
  },

  async scheduled(_event, { SMTP_PASSWORD, SMTP_USER }, _ctx) {
    console.log(SMTP_USER);
    const li = await smtpCheck("smtp.js0.site", SMTP_USER, SMTP_PASSWORD);
    console.log(li);
  },
};
