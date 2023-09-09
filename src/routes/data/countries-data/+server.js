import { getAllVisitorLogEntries } from '$lib/visitor-log'
import { json } from '@sveltejs/kit'
 
export async function GET() {
  let getLogEntriesResp = await getAllVisitorLogEntries()
  return json(getLogEntriesResp)
}
