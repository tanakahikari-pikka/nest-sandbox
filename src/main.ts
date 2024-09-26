import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    origin: '*',
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',  // 許可するHTTPメソッド
    allowedHeaders: 'Content-Type, Authorization',  // 許可するヘッダー
  });
  await app.listen(80);
}
bootstrap();
