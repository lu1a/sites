import { sendVisitorLog } from '$lib/visitor-log'

/** @type {import('@sveltejs/kit').Handle} */
export async function handle({ event, resolve }) {
  const editableRequest = event.request.clone();
  let bodyString = await editableRequest.text()
  bodyString = bodyString.replace(/{/g, "[[").replace(/}/g, "]]")
  sendVisitorLog({
    "for_user": 1, // me
    "visited_at": new Date().toISOString(),
    "url_path": event.request.headers.get("X-Original-URL"),
    "ip_address": event.request.headers.get("X-Real-IP"),
    "geolocation": null, // TODO
    "ip_isp": null, // TODO
    "browser": event.request.headers.get("User-Agent"),
    "operating_system": event.request.headers.get("Sec-Ch-Ua-Platform"),
    "is_mobile": event.request.headers.get("Sec-Ch-Ua-Mobile") == "?1",
    "referer_url": null, // TODO
    "preferred_languages": event.request.headers.get("Accept-Language"),
    "cookies": event.cookies.getAll().map(cookie => `${cookie.name}=${cookie.value}`).join(','),
    "body": bodyString,
  })
  
  const response = await resolve(event)
  return response
}
