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

export async function getAllVisitorLogEntries() {
  try {
    let visitorLogEntriesResp = await fetch(`${LIVE_EXPLAN_API_URL}/visitor-log-entries`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${LIVE_EXPLAN_API_TOKEN}`,
      },
    })
    let visitorLogEntries = await visitorLogEntriesResp.json()
    return visitorLogEntries
  } catch (e) {
    console.log("Whoops, GETting the visitor log failed.", e)
    throw e
  }
}
