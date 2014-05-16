'use strict'

statusCodes =
  100:
    title: "Continue"
    type: "Informational"
    description: "The client SHOULD continue with its request. This interim
      response is used to inform the client that the initial part of the
      request has been received and has not yet been rejected by the server.
      The client SHOULD continue by sending the remainder of the request or,
      if the request has already been completed, ignore this response. The
      server MUST send a final response after the request has been completed.
      See section 8.2.3 for detailed discussion of the use and handling of
      this status code."
  101:
    title: "Switching Protocols"
    type: "Informational"
    description: "The server understands and is willing to comply with the
      client's request, via the Upgrade message header field (section 14.42),
      for a change in the application protocol being used on this connection.
      The server will switch protocols to those defined by the response's
      Upgrade header field immediately after the empty line which terminates
      the 101 response."
  200:
    title: "OK"
    type: "Successful"
    description: "The request has succeeded."
  201:
    title: "Created"
    type: "Successful"
    description: "The request has been fulfilled and resulted in a new
      resource being created. The newly created resource can be referenced
      by the URI(s) returned in the entity of the response, with the most
      specific URI for the resource given by a Location header field.
      The response SHOULD include an entity containing a list of resource
      characteristics and location(s) from which the user or user agent
      can choose the one most appropriate. The entity format is specified
      by the media type given in the Content-Type header field.
      The origin server MUST create the resource before returning the 201
      status code. If the action cannot be carried out immediately,
      the server SHOULD respond with 202 (Accepted) response instead."
  202:
    title: "Accepted"
    type: "Successful"
    description: "The request has been accepted for processing, but the
      processing has not been completed. The request might or might not
      eventually be acted upon, as it might be disallowed when processing
      actually takes place. There is no facility for re-sending a status
      code from an asynchronous operation such as this."
  203:
    title: "Non-Authoritative Information"
    type: "Successful"
    description: "The returned metainformation in the entity-header is
      not the definitive set as available from the origin server, but
      is gathered from a local or a third-party copy. The set presented
      MAY be a subset or superset of the original version. For example,
      including local annotation information about the resource might
      result in a superset of the metainformation known by the origin
      server. Use of this response code is not required and is only
      appropriate when the response would otherwise be 200 (OK)."
  204:
    title: "No Content"
    type: "Successful"
    description: "The server has fulfilled the request but does not need
      to return an entity-body, and might want to return updated
      metainformation. The response MAY include new or updated
      metainformation in the form of entity-headers, which if
      present SHOULD be associated with the requested variant."
  205:
    title: "Reset Content"
    type: "Successful"
    description: "The server has fulfilled the request and the user
      agent SHOULD reset the document view which caused the request to
      be sent. This response is primarily intended to allow input for
      actions to take place via user input, followed by a clearing of
      the form in which the input is given so that the user can easily
      initiate another input action. The response MUST NOT include an
      entity."
  206:
    title: "Partial Content"
    type: "Successful"
    description: "The server has fulfilled the partial GET request for
      the resource. The request MUST have included a Range header field
      indicating the desired range, and MAY have included an If-Range
      header field to make the request conditional."
  300:
    title: "Multiple Choices"
    type: "Redirection"
    description: "The requested resource corresponds to any one of a
      set of representations, each with its own specific location, and
      agent- driven negotiation information (section 12) is being
      provided so that the user (or user agent) can select a preferred
      representation and redirect its request to that location."
  301:
    title: "Moved Permanently"
    type: "Redirection"
    description: "The requested resource has been assigned a new
      permanent URI and any future references to this resource SHOULD
      use one of the returned URIs. Clients with link editing capabilities
      ought to automatically re-link references to the Request-URI to one
      or more of the new references returned by the server, where possible.
      This response is cacheable unless indicated otherwise."
  302:
    title: "Found"
    type: "Redirection"
    description: "The requested resource resides temporarily under a
      different URI. Since the redirection might be altered on occasion,
      the client SHOULD continue to use the Request-URI for future requests.
      This response is only cacheable if indicated by a Cache-Control
      or Expires header field."
  303:
    title: "See Other"
    type: "Redirection"
    description: "The response to the request can be found under a different
      URI and SHOULD be retrieved using a GET method on that resource.
      This method exists primarily to allow the output of a POST-activated
      script to redirect the user agent to a selected resource.
      The new URI is not a substitute reference for the originally requested
      resource. The 303 response MUST NOT be cached, but the response to the
      second (redirected) request might be cacheable."
  304:
    title: "Not Modified"
    type: "Redirection"
    description: "If the client has performed a conditional GET request and
      access is allowed, but the document has not been modified, the server
      SHOULD respond with this status code. The 304 response MUST NOT contain
      a message-body, and thus is always terminated by the first empty line
      after the header fields."
  305:
    title: "Use Proxy"
    type: "Redirection"
    description: "The requested resource MUST be accessed through the proxy
      given by the Location field. The Location field gives the URI of the
      proxy. The recipient is expected to repeat this single request via
      the proxy. 305 responses MUST only be generated by origin servers."
  306:
    title: "(Unused)"
    type: "Redirection"
    description: "The 306 status code was used in a previous version of the
      specification, is no longer used, and the code is reserved."
  307:
    title: "Temporary Redirect"
    type: "Redirection"
    description: "The requested resource resides temporarily under a
      different URI. Since the redirection MAY be altered on occasion,
      the client SHOULD continue to use the Request-URI for future requests.
      This response is only cacheable if indicated by a Cache-Control or
      Expires header field."
  400:
    title: "Bad Request"
    type: "Client Error"
    description: "The request could not be understood by the server due to
      malformed syntax. The client SHOULD NOT repeat the request without
      modifications."
  401:
    title: "Unauthorized"
    type: "Client Error"
    description: "The request requires user authentication. The response
      MUST include a WWW-Authenticate header field (section 14.47) containing
      a challenge applicable to the requested resource. The client MAY repeat
      the request with a suitable Authorization header field (section 14.8).\n
      If the request already included Authorization credentials, then the 401
      response indicates that authorization has been refused for those
      credentials. If the 401 response contains the same challenge as the
      prior response, and the user agent has already attempted authentication
      at least once, then the user SHOULD be presented the entity that was
      given in the response, since that entity might include relevant
      diagnostic information. HTTP access authentication is explained
      in \"HTTP Authentication: Basic and Digest Access Authentication\""
  402:
    title: "Payment Required"
    type: "Client Error"
    description: "This code is reserved for future use."
  403:
    title: "Forbidden"
    type: "Client Error"
    description: "The server understood the request, but is refusing to
      fulfill it. Authorization will not help and the request SHOULD NOT
      be repeated. If the request method was not HEAD and the server
      wishes to make public why the request has not been fulfilled, it SHOULD
      describe the reason for the refusal in the entity. If the server does
      not wish to make this information available to the client, the status
      code 404 (Not Found) can be used instead."
  404:
    title: "Not Found"
    type: "Client Error"
    description: "The server has not found anything matching the Request-URI.\n
      No indication is given of whether the condition is temporary or
      permanent. The 410 (Gone) status code SHOULD be used if the server
      knows, through some internally configurable mechanism, that an old
      resource is permanently unavailable and has no forwarding address.\n
      This status code is commonly used when the server does not wish to
      reveal exactly why the request has been refused, or when no other
      response is applicable."
  405:
    title: "Method Not Allowed"
    type: "Client Error"
    description: "The method specified in the Request-Line is not allowed
      for the resource identified by the Request-URI. The response MUST
      include an Allow header containing a list of valid methods for the
      requested resource."
  406:
    title: "Not Acceptable"
    type: "Client Error"
    description: "The resource identified by the request is only capable
      of generating response entities which have content characteristics
      not acceptable according to the accept headers sent in the request.\n
      Unless it was a HEAD request, the response SHOULD include an
      entity containing a list of available entity characteristics and
      location(s) from which the user or user agent can choose the one
      most appropriate."
  407:
    title: "Proxy Authentication Required"
    type: "Client Error"
    description: "This code is similar to 401 (Unauthorized), but
      indicates that the client must first authenticate itself with the
      proxy.\n
      The proxy MUST return a Proxy-Authenticate header field containing
      a challenge applicable to the proxy for the requested resource.\n
      The client MAY repeat the request with a suitable Proxy-Authorization
      header field (section 14.34)."
  408 :
    title: "Request Timeout"
    type: "Client Error"
    description: "The client did not produce a request within the 14:27
      that the server was prepared to wait. The client MAY repeat the
      request without modifications at any later time."
  409:
    title: "Conflict"
    type: "Client Error"
    description: "The request could not be completed due to a conflict
      with the current state of the resource. This code is only allowed
      in situations where it is expected that the user might be able to
      resolve the conflict and resubmit the request. The response body
      SHOULD include enough information for the user to recognize the
      source of the conflict. Ideally, the response entity would include
      enough information for the user or user agent to fix the problem;
      however, that might not be possible and is not required."
  410:
    title: "Gone"
    type: "Client Error"
    description: "The requested resource is no longer available at the
      server and no forwarding address is known. This condition is expected
      to be considered permanent. Clients with link editing capabilities
      SHOULD delete references to the Request-URI after user approval.
      If the server does not know, or has no facility to determine, whether
      or not the condition is permanent, the status code 404 (Not Found)
      SHOULD be used instead. This response is cacheable unless indicated
      otherwise."
  411:
    title: "Length Required"
    type: "Client Error"
    description: "The server refuses to accept the request without a defined
    Content- Length. The client MAY repeat the request if it adds a valid
    Content-Length header field containing the length of the message-body
    in the request message."
  412:
    title: "Precondition Failed"
    type: "Client Error"
    description: "The precondition given in one or more of the request-header
      fields evaluated to false when it was tested on the server. This
      response code allows the client to place preconditions on the current
      resource metainformation (header field data) and thus prevent the
      requested method from being applied to a resource other than the one
      intended."
  413:
    title: "Request Entity Too Large"
    type: "Client Error"
    description: "The server is refusing to process a request because the
      request entity is larger than the server is willing or able to process.
      The server MAY close the connection to prevent the client from
      continuing the request."
  414:
    title: "Request-URI Too Long"
    type: "Client Error"
    description: "The server is refusing to service the request because the
      Request-URI is longer than the server is willing to interpret. This
      rare condition is only likely to occur when a client has improperly
      converted a POST request to a GET request with long query information,
      when the client has descended into a URI \"black hole\" of redirection
      (e.g., a redirected URI prefix that points to a suffix of itself), or
      when the server is under attack by a client attempting to exploit
      security holes present in some servers using fixed-length buffers for
      reading or manipulating the Request-URI."
  415:
    title: "Unsupported Media Type"
    type: "Client Error"
    description: "The server is refusing to service the request because the
      entity of the request is in a format not supported by the requested
      resource for the requested method."
  416:
    title: "Requested Range Not Satisfiable"
    type: "Client Error"
    description: "A server SHOULD return a response with this status code if
      a request included a Range request-header field (section 14.35), and
      none of the range-specifier values in this field overlap the current
      extent of the selected resource, and the request did not include an
      If-Range request-header field. (For byte-ranges, this means that the
      first- byte-pos of all of the byte-range-spec values were greater than
      the current length of the selected resource.)"
  417:
    title: "Expectation Failed"
    type: "Client Error"
    description: "The expectation given in an Expect request-header field
      (see section 14.20) could not be met by this server, or, if the server
      is a proxy, the server has unambiguous evidence that the request could
      not be met by the next-hop server."
  500:
    title: "Internal Server Error"
    type: "Server Error"
    description: "The server encountered an unexpected condition which
      prevented it from fulfilling the request."
  501:
    title: "Not Implemented"
    type: "Server Error"
    description: "The server does not support the functionality required to
      fulfill the request. This is the appropriate response when the server
      does not recognize the request method and is not capable of supporting
      it for any resource."
  502:
    title: "Bad Gateway"
    type: "Server Error"
    description: "The server, while acting as a gateway or proxy, received
      an invalid response from the upstream server it accessed in attempting
      to fulfill the request."
  503:
    title: "Service Unavailable"
    type: "Server Error"
    description: "The server is currently unable to handle the request due
      to a temporary overloading or maintenance of the server. The
      implication is that this is a temporary condition which will be
      alleviated after some delay. If known, the length of the delay MAY
      be indicated in a Retry-After header. If no Retry-After is given,
      the client SHOULD handle the response as it would for a 500 response."
  504:
    title: "Gateway Timeout"
    type: "Server Error"
    description: "The server, while acting as a gateway or proxy, did not
      receive a timely response from the upstream server specified by the
      URI (e.g. HTTP, FTP, LDAP) or some other auxiliary server (e.g. DNS)
      it needed to access in attempting to complete the request."
  505:
    title: "HTTP Version Not Supported"
    type: "Server Error"
    description: "The server does not support, or refuses to support, the
      HTTP protocol version that was used in the request message. The server
      is indicating that it is unable or unwilling to complete the request
      using the same major version as the client, as described in section
      3.1, other than with this error message. The response SHOULD contain
      an entity describing why that version is not supported and what other
      protocols are supported by that server."
  599:
    title: "Tornado Timeout"
    type: "Server Error"
    description: "Connection was closed by a Tornado Server due to an timeout."

class StatusCodeFactory
  constructor: ->
    @statusCodes = statusCodes

  getInfo: (codeNumber) ->
    if @statusCodes[codeNumber]? then @statusCodes[codeNumber] else null

  getTitle: (codeNumber) ->
    info = @getInfo(codeNumber)
    if info then info['title'] else null

  getDescription: (codeNumber) ->
    info = @getInfo(codeNumber)
    if info then info['description'] else null

  getType: (codeNumber) ->
    info = @getInfo(codeNumber)
    if info then info['type'] else null


angular.module('holmesApp')
  .factory 'StatusCodeFactory', () ->
    return new StatusCodeFactory()
