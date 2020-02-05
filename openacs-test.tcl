ad_page_contract {

    This is called by server monitoring scripts, such as
    keepalive (see http://arsdigita.com/free-tools/keepalive.html)
    if it doesn't return "success" then they are supposed
    to kill the AOLserver.

    You can also use this with our Uptime monitoring system,
    described in Chapter 15 of http://photo.net/wtr/thebook/

    This tests total db connectivity of all 3 database pools.

    @cvs-id $Id: dbtest.tcl,v 1.2 2009/11/17 22:26:13 ryang Exp $
} { }

if { [catch {
    db_foreach check_pool1 "select 1 from party_names limit 1" {
        db_foreach check_pool2 "select 1 from party_names limit 1" {
            db_1row check_pool3 "select 1 from party_names limit 1"
        }
    }
} errmsg] } {
    ns_return 500 text/plain "1"
} else {
    ns_return 200 text/plain "0"
}