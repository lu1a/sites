// @ts-nocheck
import { LIVE_EXPLAN_API_URL, LIVE_EXPLAN_API_TOKEN } from '$env/static/private'

export async function sendVisitorLog(requestObj) {
  try {
    await fetch(`${LIVE_EXPLAN_API_URL}/visitor-log-entry`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${LIVE_EXPLAN_API_TOKEN}`,
      },
      body: JSON.stringify(requestObj),
    })
  } catch (e) {
    console.log("Whoops, the visitor log died.", e)
  }
}
