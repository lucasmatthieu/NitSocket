//
//  socketerrors.h
//  TestSockets
//
//  Created by Matthieu on 2013-04-21.
//  Copyright (c) 2013 Matthieu. All rights reserved.
//

#include <errno.h>

#define SOCKET_CREATION_ERROR   -18
#define SOCKET_GETHOST_ERROR    -19
#define SOCKET_CONNECT_ERROR    -20


/*
 * Socket() errno description
 */
#define EPROTONOSUPPORT_DESC    "Protocole unsupported\n"
#define EAFNOSUPPORT_DESC       "Address family unsupported\n"
#define ENFILE_DESC             "Processus descriptors table full\n"
#define EMFILE_DESC             "File table full\n"
#define EACCES_DESC             "Unauthorized socket creation / access\n"
#define ENOMEM_DESC             "Insufficient free space to allocate buffers\n"
#define ENOBUFS_DESC            ENOMEM_DESC
#define EINVAL_DESC             "Unknown protocol / protocol family\n"
/*
 * Gethostbyname() h_errno description
 */
#define HOST_NOT_FOUND_DESC     "Host not found\n"
#define NO_DATA_DESC            "Valid name but no ip address associated\n"
#define NO_ADDRESS_DESC         NO_DATA_DESC
#define NO_RECOVERY_DESC        "Fatal error in DNS server occured\n"
#define TRY_AGAIN_DESC          "Fatal error in DNS server occured, try again later\n"
/*
 * Connect() errno description
 */
#define EBADF_DESC              "Wrong descriptor\n"
#define EFAULT_DESC             "Address structure points oustide of address space\n" // La structure d'adresse pointe en dehors de l'espace d'adressage.
#define ENOTSOCK_DESC           "Descriptor do not correspond to a socket\n"
#define EISCONN_DESC            "Socket is already connected\n"
#define ECONNREFUSED_DESC       "Connection refused by server\n"
#define ETIMEDOUT_DESC          "Connection delay expired. The server may be over charged to accept new connection.\n"
#define ENETUNREACH_DESC        "Unreachable network\n"
#define EADDRINUSE_DESC         "Address already used\n"
#define EINPROGRESS_DESC        "Non-blocking socket, and connection can not be establish.\n"
#define EALREADY_DESC           "Non-blocking socket, and a previous connection attempt has not yet completed\n"
#define EAGAIN_DESC             "No local port available, or not enough free space in the routing table.\n"
#define EPERM_DESC              EACCES_DESC

