<master src="doc-master">
<property name=title>Jabber Introduction</property>


<center>
<a href="jabber-installation">Next: Installation Guide</a>
</center>

<h1>Introduction</h1>


<p>This document explains the Jabber Server, which functionality and characteristics 
it has, so everyone can get a better overview.</p>

Jabber is an XML-based system for the near-real-time exchange of messages and
presence.(A strong foundation in XML, which makes structured, intelligent
messaging possible not only between human users but also between software
applications.) Jabber uses a client-server architecture, not a client-to-client
architecture. All Jabber messages and data from one client to another must go
through the server. Any client is free to negotiate a direct connection to
another client, but those connections are for application-specific usage only.
There are even specific instances where this is encouraged, such as file
transfers, but those instances are negotiated first within the context of a
client-server framework. Jabber uses a distributed Network, its architecture is
modeled after that of the e-mail system. Each user has their local server which
receives information for them, and the servers transfer messages and presence
information among themselves. There can exist any number of Jabber servers which
accept connections from clients as well as communicate to other Jabber servers.
Each server functions independently of the others, and maintains its own user
list. Any Jabber server can talk to any other Jabber server that is accessible
via the Internet. A particular user is associated with a specific server by a
unique identefier (jid) that is like an emailadress.
<p>
<b>Jabber ID (jid)</b>
<p>Jabber IDs are used both externally and internally to express ownership or
routing information. A Jabber ID is made up of a domain, node, and resource in
the following format: user@host/resource or [node@]domain[/resource]. It is
designed as a URI (Uniform Resource Identifier), a URI is a character string
used to identify a resource (such as a file, in this case a session of a Jabber
Server entity) from anywhere on the Internet by type and location. The term
’URL’ (Uniform Resource Locator) is a specific type of URI. For more
information, visit http://www.w3.org/Addressing/.</p>
<b>The three main branches of the Jabber communication.</b>
<p>-Info/Query:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In the Jabber protocol, Info/Query is a data structure used to
obtain information about a Jabber Entity or to set information for an entity.
<br>
-Presence:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Presence indicates whether a Jabber Entity is available for
communication. It includes basic Availability (i.e., online vs. offline), as
well as status indicators that capture various Availability Types.<br>
-Message:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A Message is used to transport information (a message) between two or more entitys
of a Jabber Server.</p>
<b>Jabber Server</b>
<p>The Jabber Server is the software that connects and communicates with other
Jabber clients and servers. All communications for a client are directed to the
server and then passed to the client. All client preferences and data are stored
on the server. The Jabber server plays two primary roles: 1. Listening for
client connections and communicating directly with client applications. 2.
Communicating with other Jabber servers. The Jabber Server is designed to be
modular, it can be extended by modules (JSM) that implement speciale purposes,
or comunicat with other deamons that register them selfs at the Jabber core
Server (not like then the modules, they are not a part of it) , and translate
the Jabber native protocol to a protocol of any other IM Service. This protocol
translation deamons are called Transports, the communication between a Transport
and the core Server is based on Networkprotokols such as TCP/IP and can be
hosted on different Servers.The Jabber core Server can be configured in one
config file that is loaded into the Jabber core Server, it determines what
modules of the JSM and what Transports should be loaded (on start up) along with
detailed configuration information for each.</p>
<b>Transport</b>
<p>A component of the Jabber server that provides a bridge over the Internet or
a network, between the Jabber Server and any non-Jabber system or network. How
is it doing that: -Protocol A protocol is a formalized set of instructions that
developers follow when creating applications, including Jabber applications.
-Native Protocol A native protocol is the format in which communications occur
within a particular service. For example, the AIM Transport communicates with
AIM by translating Jabber’s native XML protocol into AIM’s native protocol
and vice-versa.
<p><b>Client</b>
<p>-Resource:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The resource of a Jabber ID can provide additional information
about how a user is accessing a Jabber server. A Resource can be the location
from which a user is connecting (e.g., home or work), the type of device a user
is connecting with (e.g., notebook or handheld), or the user’s specific Jabber
Client (e.g., JIM or WinJab).<br>
-Priority:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Priority is a user-defined setting that
determines the importance of each Resource a Jabber user is using to access the
Jabber server. The server will send messages and presence information to the
highest-priority resource, which is known as the Primary Resource. This enables
a user to connect to the server from multiple locations or devices, but only
receive messages at a single device or location.&nbsp;<br> 
-Roster:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A list of Jabber Users or other Jabber Entities to whom a
Jabber User is subscribed. A user’s roster is often the combination of a
user’s Personal Groups and Shared Groups. -Subscription: A subscription is a
request to receive presence updates from a Jabber User or other Jabber Entity.
The receiving entity may refuse a subscription, preventing the requesting party
from seeing presence updates. If the receiving entity approves the subscription,
the requesting party will see presence updates.</p>

<p><b>Important:</b><br>
<br>
 The OACS Jabber server acts as one buddy, so if you send a message the receiver
of the message will think that the user "OACS" send him this message. Of course we want the receiver
to know who send him the message, so we append on every message your name at the beginning. Furthermore
the receiver cannot send you messages back if you send him the message via Webpages, because this way you would 
be the OACS-user and not you!Therefore it is impossible for the Jabber server to track the messages and find
the original sender. So if you want to be recognized perfectly by the receiver and be able to receive messages aswell, 
you have to send your messages through the Jabber Applet, because this Jabber Applet acts like a normal Jabber Client
and you would not send your messages via the Jabber server as general OACS-user, but  as Jabber user with his own JabberID.
</p> 

<center>
<a href="jabber-installation">Next: Installation Guide</a>
</center>

<hr>
<p>Author:
<a href=mailto:bkiesbye@sussdorff-roy.com> Bjoern Kiesbye</a>
</p>

