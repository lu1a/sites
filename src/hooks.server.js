import { LIVE_EXPLAN_API_URL, LIVE_EXPLAN_API_TOKEN } from '$env/static/private'

/** @type {import('@sveltejs/kit').Handle} */
export async function handle({ event, resolve }) {
  if (event.url.pathname.startsWith('/custom')) {
    return new Response('custom response')
  }

  try {
    await fetch(`${LIVE_EXPLAN_API_URL}/visitor-log-entry`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${LIVE_EXPLAN_API_TOKEN}`,
      },
      body: JSON.stringify({
        "for_user": 1, // me
        "visited_at": new Date().toISOString(),
        "url_path": event.url.href,
        "ip_address": event.getClientAddress(),
        "geolocation": null, //TODO
        "ip_isp": null, //TODO
        "browser": event.request.headers.get("User-Agent"),
        "operating_system": event.request.headers.get("Sec-Ch-Ua-Platform"),
        "is_mobile": event.request.headers.get("Sec-Ch-Ua-Mobile") == "?1",
        "referer_url": event.request.referrer,
        "preferred_languages": event.request.headers.get("Accept-Language"),
        "cookies": event.cookies.getAll().map(cookie => `${cookie.name}=${cookie.value}`).join(','),
        "body": event.request.body,
      }),
    })
  } catch {
    console.log("Whoops, the visitor log died.")
  }
  
  const response = await resolve(event)
  return response
}