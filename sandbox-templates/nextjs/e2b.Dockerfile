# Use Debian-based Node image
FROM node:21-slim

# Install curl
RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy script into PATH
COPY compile_page.sh /usr/local/bin/compile_page.sh
RUN chmod +x /usr/local/bin/compile_page.sh

# Set working directory
WORKDIR /home/user/nextjs-app

# Create Next.js app
RUN npx --yes create-next-app@15.3.3 . --yes

# Install shadcn
RUN npx --yes shadcn@2.6.3 init --yes -b neutral --force
RUN npx --yes shadcn@2.6.3 add --all --yes

# Move the Next.js app to /home/user and clean up
RUN mv /home/user/nextjs-app/* /home/user/ && rm -rf /home/user/nextjs-app

# Run compile_page.sh by default
CMD ["compile_page.sh"]
