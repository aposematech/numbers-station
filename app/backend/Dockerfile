# https://docs.aws.amazon.com/lambda/latest/dg/images-create.html
# https://docs.aws.amazon.com/lambda/latest/dg/python-image.html

FROM public.ecr.aws/lambda/python:3.9

# Copy function code
COPY app/backend/app.py ${LAMBDA_TASK_ROOT}

# Install the function's dependencies using file requirements.txt
# from your project folder.
COPY app/backend/requirements.txt .
RUN  pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.handler" ]
