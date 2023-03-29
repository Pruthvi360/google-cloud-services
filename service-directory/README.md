## Overview ##
Service Directory helps reduce the complexity of management and operations by providing a single place to publish, discover, and connect services. 
It is a managed service that enhances service inventory management at scale so you don’t have to. Service Directory provides real-time service information, 
whether you have a few service endpoints or thousands. This helps ensure that your applications only resolve the most updated information of their resources, 
increasing the reachability of your services.
With Service Directory, you can easily understand all your services across multi-cloud environments. This includes workloads running in Compute Engine VMs, Google  Kubernetes Engine (GKE), as well as external services running on-prem and third-party clouds. It improves application reachability by maintaining the endpoint 
 information for all your services.
Service Directory solves the following problems:

## Interoperability: 
                     Service Directory is a universal naming service that works across Google Cloud, multi-cloud, and on-premises. 
                     You can migrate services between these environments and still use the same service name to register and resolve endpoints.

## Service management: 
                       Service Directory is a managed service. Your organization doesn't have to worry about the high availability, redundancy,
                       scaling, or maintenance concerns of maintaining your own service registry.

## Access Control: 
                   With Service Directory, you can control who can register and resolve your services using IAM. 
                   Assign Service Directory roles to teams, service accounts, and organizations.

## Limitations of pure DNS: 
                            DNS resolvers can be unreliable in terms of respecting TTLs and caching, cannot handle larger record sizes, and do not offer an easy way
                            to serve metadata to users. In addition to DNS support, Service Directory offers HTTP and gRPC APIs to query and resolve services.


1. Enable to enable the Service Directory API.
2. click +REGISTER SERVICE.
3. select Standard for Service type.
4. Next
5. use us-central1.
6. Create Name-spaces > example-namespace > Create
7. Service Name > example-service > create

## Configuring an endpoint

1. Click +Add Endpoint.
2. Endpoint name > example-endpoint
3. Ip Address= 0.0.0.0 > Port= 80

## Configuring a Service Directory DNS zone

1. Network Services menu, select Cloud DNS.
2. Create zone. > Private 
3. Zone Name = example-zone-name
4. DNS Name = myzone.example.com
5. Options = select Use a service directory namespace
6. Network = Default
7. Region = us-central1
8. Name-spaces = example-namespace
