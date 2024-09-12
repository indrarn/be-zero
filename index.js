import Fastify from 'fastify';
import 'dotenv/config'

const fastify = Fastify({
  logger: true
});


fastify.get('/', async function handler(request, reply) {
  return { hello: 'world' };
});


try {
  await fastify.listen({ port: process.env.PORT || 3000, host: '0.0.0.0' });
  console.log(`Server is running at http://localhost:${process.env.PORT || 3000}`);
} catch (err) {
  fastify.log.error(err);
  process.exit(1);
}

adadada
