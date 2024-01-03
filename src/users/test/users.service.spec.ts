import { Test, TestingModule } from '@nestjs/testing';
import { UsersService } from '../users.service';
import { PrismaService } from '../prisma.service';

describe('UsersService', () => {
  let service: UsersService;
  let prisma: PrismaService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [UsersService, PrismaService],
    }).compile();

    service = module.get<UsersService>(UsersService);
    prisma = module.get<PrismaService>(PrismaService);
  });

  describe('insertOne', () => {
    it('insert a user', async () => {
      // given
      const userName = 'test user';

      // when
      await service.insertOne({ name: userName });

      // then
      const user = await prisma.user.findFirst({
        where: { name: userName },
      });
      expect(user).toHaveProperty('name', userName);

      // cleanup
      await prisma.user.deleteMany({
        where: { name: userName },
      });
    });
  });
});
