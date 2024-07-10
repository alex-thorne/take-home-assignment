# take-home-assignment
_An example take-home evaluation for basic DevOps engineer candidate qualifications_

## Introduction

For the last several years, one of the responsibilities of my role as the line manager for an operations unit has been to facilitate the hiring of DevOps engineers. Ours was a relatively small organization; from 2018 when I took the unit-head position to 2024, we grew from 13 to 27 people, 8 to 18 of which DevOps engineers (the remainder being various roles supporting Operations & Service Delivery). In hiring those 10 DevOps engineers, we probably received >500 applications, and interviewed at least 100.

As part of our hiring process, we would initially hold a short call with candidates. If fit seemed OK, we would ask candidates if they were willing to fulfill a "take-home" assignment prior to a second round, which we could use as a basis for further discussion.

My personal feeling on the effectiveness or benefit of the take-home assignment portion of that team's hiring process has gone back and forth over the years. Ultimately I would say: it served its purpose. As I'm moving to new teams now, which are thinking about their own hiring processes, I've been reflecting on what I might have done differently in our hiring.

First however, I wanted to capture the history of this little task, and, _having never actually completed the take-home assignment myself_, I found it funny to do so.

## Guidelines of the assignment

Below is the email body we'd send out after agreeing with the candidates in the phone screening:

<details>
<summary>Click to expand full take-home evaluation prompt</summary>

> Hello [candidates name],
>
> Thank you for taking the time to interview with us today. As discussed, we'd like to ask you to complete an additional task to give us a hands-on demonstration of your ability to work with some of the technologies and concepts we spoke about today.
>
> Please follow the guidelines below and return your result to us. Let us know if you have questions or need any clarification. Let us know if you have questions or need any clarification. You may take as much time as you need, but please try to keep in touch with us, and feel free to send us what you have even if it’s not completed if you get stuck or can’t find any available free time - we really do want to be flexible here and don't want to ask too much of you.
>
> Best regards,
>
> [Technical screening interviewer's name]
>
>
>>Task:
>>
>>Utilize IaC solutions such as ansible and terraform to fully automate the deployment process of a small application described below. Please make sure that the solution you deliver is reusable: it is important that the code should be easily modified by your colleagues to deploy other modules or components.
>>
>>The application:
>>
>>1. Write a python application that displays Chuck Norris jokes from [this API](https://api.chucknorris.io/).
>>2. The application should render a simple html page with the data from point 1.
>>3. Prepare the application to run in a Docker container.
>>
>>Additional requirements:
>>
>>1. The application you create should be running in a container, (please provide the Dockerfile which you have built the image with)  
>>2. Use official vanilla alpine-linux [https://hub.docker.com/_/alpine/] as base image from Docker Hub.
>>3. A webserver (e.g. apache, nginx) should be deployed as proxy.
>>
>>Expected project deliverables:
>>
>>1. All content of your project is located in a private repository (BitBucket, GitHub, etc.)
>>2. A README file is included which explains your solution and serves as a manual to deploy it. 
>>3. The project does not utilize pre-built docker images.
>>
>>Please keep in mind:
>>
>>1. If you chose to use any public code, please mention this. Provide links to used code.
>>2. If you will not be able to complete the task, feel free to submit any progress you have made.
>>3. The purpose of task is not the finished product, but your approach. This is not a race, and you are free to contact us with questions.

</details>

<br></br><br></br>

# #chuckstuff: Chuck Norris facts made possible via Terraform, Ansible, and Docker. 

Follow the steps below to deploy this sample containerized application to GCP Compute Engine instance using Terraform and Ansible.

## Prerequisites

- Terraform
- Ansible
- Existing GCP account and project

## Setup

1. Clone the repository:

    ```bash
    git clone git@github.com:alex-thorne/take-home-assignment.git
    cd take-home-assignment
    ```

2. Adjust account & credentials placeholders in `/terraform.tfvars` & `ansible.cfg`

3. Apply Terraform from /terraform directory:

    ```bash
    cd terraform
    terraform init
    terraform apply
    ```

4. The public IP address of the provisioned instance will be shown in the Terraform output:

    ```bash
    Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
    Outputs:
    instance_ip = "xx.xxx.xx.xx"
    ```

5. Update the Ansible hosts file with the instance IP:

    ```bash
    echo -e "[app]\n$(terraform output instance_ip)" > ../ansible/inventory
    ```

6. Deploy the Docker container via Ansible:

    ```bash
    cd ../ansible
    ansible-playbook playbook.yml
    ```

7. Profit?
    - note: this project doesn't include any considerations for internet ingress, so to verift the docker images are running and serving up the chuck stuff correctly you'll need to be clever.

### Clean up, Chuck!

Don't forget to tear everything down:

```bash
cd ../terraform
terraform destroy
```

## Test Locally

Docker-compose included for convient chucking @localhost

```bash
cd app
docker-compose up --build
```

## TODO
[ ] error handling in ansible

[ ] MORE CHUCK (I'm thinking animated kicks)
