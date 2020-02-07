From: Chet Ramey <chet.ramey@case.edu>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Fri, 7 Feb 2020 11:16:15 -0500
Message-ID: <ec73159a-2c24-b91c-c23e-5429339752aa@case.edu>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
 <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl>
Reply-To: chet.ramey@case.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
In-Reply-To: <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl>
Content-Language: en-US
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=unsubscribe>
List-Archive: <https://lists.gnu.org/archive/html/bug-bash>
List-Post: <mailto:bug-bash@gnu.org>
List-Help: <mailto:bug-bash-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=subscribe>
Errors-To: bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org
Sender: "bug-bash" <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
To: Harald van Dijk <harald@gigawatt.nl>, Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>, busybox <busybox@busybox.net>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>, Robert Elz <kre@munnari.OZ.AU>, Jilles Tjoelker <jilles@stack.nl>
Cc: chet.ramey@case.edu
List-Id: dash@vger.kernel.org

On 2/6/20 2:29 PM, Harald van Dijk wrote:
> On 06/02/2020 16:12, Martijn Dekker wrote:

>> When executing test.bash with dash, gwsh, Busybox ash, or FreeBSD sh,
>> then test.ash simply waits forever on executing 'wait "$!"'.
> 
> Nice test. bash leaves the process in a state where SIGCHLD is blocked, and
> the various ash-based shells do not unblock it. 

Thanks for the investigation. Bash does leave SIGCHLD blocked in this exact
set of circumstances (lastpipe+function+return at end of pipeline+exec).

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://tiswww.cwru.edu/~chet/
